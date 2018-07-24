var async = require.main.require('async');
var db = require.main.require('./src/database');
var Topics = require.main.require('./src/topics');
var categories = require.main.require('./src/categories');
var privileges = require.main.require('./src/privileges');
var meta = require.main.require('./src/meta');
var user = require.main.require('./src/user');

module.exports = function(theme) {
  function filterTids(tids, uid, filter, cid, callback) {
		async.waterfall([
			function (next) {
				if (filter === 'watched') {
					Topics.filterWatchedTids(tids, uid, next);
				} else if (filter === 'new') {
					Topics.filterNewTids(tids, uid, next);
				} else if (filter === 'unreplied') {
					Topics.filterUnrepliedTids(tids, next);
				} else {
					Topics.filterNotIgnoredTids(tids, uid, next);
				}
			},
			function (tids, next) {
				privileges.topics.filterTids('read', tids, uid, next);
			},
			function (tids, next) {
				async.parallel({
					ignoredCids: function (next) {
						if (filter === 'watched' || parseInt(meta.config.disableRecentCategoryFilter, 10) === 1) {
							return next(null, []);
						}
						user.getIgnoredCategories(uid, next);
					},
					topicData: function (next) {
						Topics.getTopicsFields(tids, ['tid', 'cid'], next);
					},
				}, next);
			},
			function (results, next) {
				cid = cid && cid.map(String);
				tids = results.topicData.filter(function (topic) {
					if (topic && topic.cid) {
						return results.ignoredCids.indexOf(topic.cid.toString()) === -1 && (!cid || (cid.length && cid.indexOf(topic.cid.toString()) !== -1));
					}
					return false;
				}).map(function (topic) {
					return topic.tid;
				});
				next(null, tids);
			},
		], callback);
	}
  function getRecentTids (callback) {
    async.parallel({
      pinnedTids: function(next) {
        db.getSortedSetRevRange('recent:tids:pinned', 0, -1, next);
      },
      normalTids: function(next) {
        db.getSortedSetRevRange('topics:recent', 0, 399, next);
      }
    }, function(err, results){
      if (err) return callback(err);
      var normalTids = results.normalTids.filter(function (tid) {
        return results.pinnedTids.indexOf(tid) === -1;
      });
      return callback(null, results.pinnedTids.concat(normalTids));
    });
  }

  Topics.getRecentTopics = function (cid, uid, start, stop, filter, callback) {
    var recentTopics = {
      nextStart: 0,
      topics: [],
    };
    if (cid && !Array.isArray(cid)) {
      cid = [cid];
    }
    async.waterfall([
      function (next) {
        if (cid) {
          var key = cid.map(function (cid) {
            return 'cid:' + cid + ':tids:lastposttime';
          });
          return db.getSortedSetRevRange(key, 0, 199, next);
        }
        return getRecentTids(next);
      },
      function (tids, next) {
        filterTids(tids, uid, filter, cid, next);
      },
      function (tids, next) {
        recentTopics.topicCount = tids.length;
        tids = tids.slice(start, stop + 1);
        Topics.getTopicsByTids(tids, uid, next);
      },
      function (topicData, next) {
        recentTopics.topics = topicData;
        recentTopics.nextStart = stop + 1;
        next(null, recentTopics);
      },
    ], callback);
  };
  theme.onPinTopic = function(data) {
    if (data.topic.isPinned) {
      db.sortedSetAdd('recent:tids:pinned', Date.now(), data.topic.tid);
    } else {
      db.sortedSetRemove('recent:tids:pinned', data.topic.tid);
    }
  };
}
