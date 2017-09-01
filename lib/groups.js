var Groups = require.main.require('./src/groups');
var async = require.main.require('async');
var db = require.main.require('./src/database');
var privileges = require.main.require('./src/privileges');
var posts = require.main.require('./src/posts');

(function () {
    Groups.getLatestMemberPosts = function (groupName, max, uid, callback) {
        async.waterfall([
            function (next) {
                Groups.getMembers(groupName, 0, -1, next);
            },
            function (uids, next) {
                if (!Array.isArray(uids) || !uids.length) {
                    return callback(null, []);
                }
                var keys = uids.map(function (uid) {
                    return 'uid:' + uid + ':posts';
                });
                db.getSortedSetRevRange(keys, 0, max - 1, next);
            },
            function (pids, next) {
                privileges.posts.filter('read', pids, uid, next);
            },
            function (pids, next) {
                posts.getPostSummaryByPids(pids, uid, {stripTags: false}, next);
            }
        ], callback);
    };

    return Groups;

})(module.exports)
