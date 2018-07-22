(function(module) {
	"use strict";

	var theme = {},
		meta = require.main.require('./src/meta'),
		path = require.main.require('path'),
		nconf = require.main.require('nconf'),
		async = require.main.require('async'),
		winston = require.main.require('winston'),
		validator = require.main.require('validator');

	var topics = require.main.require('./src/topics');
	var Posts = require.main.require('./src/posts');
	var categories = require.main.require('./src/categories');
	var plugins = require.main.require('./src/plugins');
	var db = require.main.require('./src/database');
	var SocketPlugins = require.main.require('./src/socket.io/plugins');
	var TopicLabel = require('./label');
	var User = require.main.require('./src/user');
	var privileges = require.main.require('./src/privileges');

	require('./groups');

	theme.defineWidgetAreas = function(areas, callback) {
		var nameList = ['register', 'login', 'categories', 'category', 'topic', 'recent', 'tags', 'popular', 'users', 'groups/list', 'unread'];
		var locations = ['sidebar', 'header', 'footer'];
		(function () {
			for (var i = 0; i < nameList.length; i++) {
				var item = nameList[i];
				var template = item + '.tpl';

				areas = areas.concat(locations.map(function (l){
					return {
						name: item + ' ' + l,
						template: template,
						location: l
					};
				}));
			}
		} ());
		callback(null, areas);
	};

	theme.preinit = function(params, callback) {
		nconf.set('base_templates_path', path.join(nconf.get('themes_path'), 'nodebb-theme-vanilla/templates'));

		callback();
	};

	theme.init = function(params, callback) {
		var app = params.router,
			middleware = params.middleware;

		app.get('/admin/plugins/v2mm', middleware.admin.buildHeader, renderAdmin);
		app.get('/api/admin/plugins/v2mm', renderAdmin);

		app.post('/api/v2mm/topic/:tid/view', function (req, res, next) {
			// increase topic viewcount when topic is external;
			var tid = req.params.tid;
			req.session.tids_viewed = req.session.tids_viewed || {};
			if (!req.session.tids_viewed[tid] || req.session.tids_viewed[tid] < Date.now() - 3600000) {
				topics.increaseViewCount(tid);
				req.session.tids_viewed[tid] = Date.now();
			}

			if (req.uid) {
				topics.markAsRead([tid], req.uid, function (err, markedRead) {
					if (err) {
						winston.error(err);
						return res.status(500).json({
							code: 500,
							message: err.message || err
						})
					}
					if (markedRead) {
						topics.pushUnreadCount(req.uid);
						topics.markTopicNotificationsRead([tid], req.uid);
					}
				});
			}
			return res.status(200).json({
               code: 200
            });
		});

		callback();
	};

	theme.addAdminNavigation = function(header, callback) {
		header.plugins.push({
			route: '/plugins/v2mm',
			icon: 'fa-paint-brush',
			name: 'V2MM Theme'
		});

		callback(null, header);
	};

	theme.getConfig = function(config, callback) {
		config.disableMasonry = !!parseInt(meta.config.disableMasonry, 10);
		callback(false, config);
	};

	theme.setExternalLinkOnSaveTopic = function(obj, callback){
		var content = obj.data.content.trim();
		var groups = content.split(/\n/);

		if (obj.data.externalLink) {
			if (!validator.isURL(obj.data.externalLink)) {
				return callback(new Error('[[v2mm:url-not-right]]'));
			}
			// save externalLink and externalComment passed from api call, see nodebb-plugin-blog-comments2
			obj.topic.externalLink = obj.data.externalLink;
		} else {
			var line = groups[0].trim();
			if (validator.isURL(line)) {
				obj.topic.externalLink = line;
			} else {
				obj.topic.externalLink = '';
			}
		}
		return callback(false, obj);
	};

	theme.filterCategoryTopics = function(data, callback){
		var pids = data.topics.map(function(topic){
			return topic && topic.mainPid;
		});

		async.waterfall([
			function (next) {
				Posts.getPostsFields(pids, ['pid', 'upvotes', 'downvotes'], next);
			}
		], function(err, res){
			if (err) {
				return callback(err);
			}

			data.topics.forEach(function(topic){
				var found = res.find(function(post){
					if (topic && topic.mainPid === post.pid) {
						topic.upvotes = post.upvotes || 0;
						topic.downvotes = post.downvotes || 0;
						return true;
					}
				});
				if (!found) {
					topic.upvotes = topic.downvotes = 0;
				}

			});

			return callback(null, data);
		});
	};

	theme.filterTopics = function (data, callback) {
		var tids = data.topics.map(function (topic) {
			return topic.tid;
		});
		TopicLabel.getTopicsLabels(tids, function (err, topicsLabels) {
			if(err) {
				return callback(err);
			}
			data.topics.forEach(function (topic, index) {
				topic.labels = topicsLabels[index];
			});

			//fix external topic teaser;
			// Maybe should remove? externalLink is not in topic content any more.
			data.topics.forEach(function(topic){
				if (topic && topic.externalLink && topic.teaser && topic.mainPid == topic.teaser.pid) {  // cannot use ===
					// remove the externalLink from the first line of teaser content.
					var _arr = topic.teaser.content.split('\n');
					if(_arr[0].indexOf(topic.externalLink) !== -1) {
						_arr.splice(0, 1);
						topic.teaser.content = _arr.join('\n');
					}
				}
			});
			return callback(null, data);

		});
	};

	theme.saveTopicToRootCategory = function(data){
		getRootCategoryId(data.topic.cid, function(err, rootCid){
			if (!err && rootCid) {
				db.sortedSetAdd('cid:' + rootCid + ':tids', data.topic.timestamp, data.topic.tid);
				db.incrObjectField('category:' + rootCid, 'topic_count');
				categories.updateRecentTid(rootCid, data.topic.tid);
			}
		});

	};

	theme.deleteTopicFromRootCategory = function (tid) {
		// TODO, should delete topics from root category when purge topics
	};

	theme.moveTopicFromRootCategory = function (obj) {
		var nullFunc = function () {};
		async.parallel([
			function (next) {
				getRootCategoryId(obj.fromCid, next);
			},
			function (next) {
				getRootCategoryId(obj.toCid, next);
			},
			function (next) {
				topics.getTopicFields(obj.tid, ['lastposttime', 'postcount'], next);
			}], function (err, results) {
				var fromRootCid = results[0];
				var toRootCid = results[1];
				var topicData = results[2];
				if (!err && fromRootCid && fromRootCid !== toRootCid) {
					if (fromRootCid !== obj.toCid) {
						db.sortedSetsRemove([
							'cid:' + fromRootCid + ':tids'
						], obj.tid, nullFunc);
						db.sortedSetsRemove('cid:' + fromRootCid + ':recent_tids', obj.tid, nullFunc);
					}
					categories.incrementCategoryFieldBy(fromRootCid, 'topic_count', -1, nullFunc);

				}
				if (!err && toRootCid && fromRootCid !== toRootCid) {
					db.sortedSetAdd('cid:' + toRootCid + ':tids', topicData.lastposttime, obj.tid);
					db.incrObjectField('category:' + toRootCid, 'topic_count');
					categories.updateRecentTid(toRootCid, obj.tid);
				}

			}
		);
	};
	theme.filterCategoryGet = function (data, callback) {
		TopicLabel.getAvailabelLabels(function (err, availabelLabels) {
			data.category.availabelLabels = availabelLabels;
			callback(err, data);
		});
	};

	theme.filterTopic = function (data, callback) {
		var topic = data.topicData;
		async.parallel({
			topicsLabels: function(next) {
				TopicLabel.getTopicsLabels([topic.tid], next);
			},
			availabelLabels: function (next) {
				TopicLabel.getAvailabelLabels(next);
			}
		}, function (err, ret) {
			if(err) {
				return callback(err);
			}
			data.topicData.labels = ret.topicsLabels[0];
			data.topicData.availabelLabels = ret.availabelLabels;
			callback(null, data);
		});
	};

	theme.onPurgeTopic = function (data) {
		TopicLabel.removeTopicLabels(data.topic.tid, function () {
			// nothing
		});
	};

	var extraProfileSites = [
	{name: 'Github', fa: 'fa-github', faText: ''},
	{name: 'Linkedin', fa: 'fa-linkedin', faText: ''},
	{name: 'Stackoverflow', fa: 'fa-stack-overflow', faText: ''},
	{name: 'Googleplus', fa: 'fa-google-plus', faText: ''},
	{name: 'Twitter', fa: 'fa-twitter', faText: ''},
	{name: 'Facebook', fa: 'fa-facebook', faText: ''},
	{name: 'Quora', fa: '', faText: 'Q'},
	{name: 'Zhihu', fa: '', faText: '知'},
	{name: 'QZone', fa: 'fa-qq', faText: ''},
	{name: 'Weibo', fa: 'fa-weibo', faText: ''},
	{name: 'Douban', fa: '', faText: '豆'},
	{name: 'V2EX', fa: '', faText: 'V'}
	];

	theme.editUserProfile = function (data, callback) {
		var err;
		extraProfileSites.forEach(function (site) {
			var value = data.data[site.name];
			if (value) {
				if (!((value.startsWith('http://') || value.startsWith('https://')) && value.length < 255)) {
					err = new Error('[[v2mm:url-not-right]]');
				}
			}
			data.fields.push(site.name);
		});
		callback(err, data);
	};

	theme.getEditUserProfile = function (userData, callback) {
		userData.extraSites = extraProfileSites.map(function (site) {
			var value = userData[site.name];

			if (site.name === 'Google' && !value && userData.gplusid) {
				value = 'https://plus.google.com/' + userData.gplusid + '/posts';
			}
			return {
				name: site.name,
				value: value,
				fa: site.fa,
				faText: site.faText
			};
		});
		callback(null, userData);
	};

	theme.getUserAccount = function (data, callback) {
		theme.getEditUserProfile(data.userData, function (err, userData) {
			callback(err, data);
		});
	};

	function getRootCategoryId(cid, callback){
		var rid;
		function _f(_c){
			categories.getCategoryField(_c, 'parentCid', function(err, pid){
				if (err) {
					return callback(err);
				}
				if (!err && pid) {
					rid = pid;
					return _f(pid);
				} else {
					return callback(null, rid);
				}
			});
		}
		_f(cid);
	}

	// add socket.io api
	SocketPlugins.v2mm = {};

	SocketPlugins.v2mm.addTagsToTopics = function(socket, data, callback) {
		var tags = data.tags;
		var tids = data.tids;

		if (tags.length && tids.length) {
			async.each(tids, function(tid, next) {
				async.waterfall([
					function (next) {
						topics.getTopicField(tid, 'timestamp', next);
					},
					function (timestamp, next) {
						topics.createTags(tags, tid, timestamp, next);
					}
				], next);
			}, callback);
		} else {
			callback();
		}
	};

	SocketPlugins.v2mm.getAllCategories = function (socket, data, callback) {
		categories.getCategoriesByPrivilege('cid:0:children', socket.uid, 'read', function (err, categoriesData) {
			if (err) {
				return callback(err);
			}
			categoriesData = categoriesData.filter(function (category) {
				return category && !category.link && !parseInt(category.parentCid, 10);
			});

			callback(null, categoriesData);
		});

	};

	SocketPlugins.v2mm.createTopicLabel = function (socket, data, callback) {
		if (!data || !data.value || !socket.uid) {
			return callback();
		}
		User.isAdministrator(socket.uid, function (err, isAdmin) {
			if (!isAdmin) {
				return callback();
			}
			TopicLabel.create(data.value, data, socket.uid, callback);
		});

	};

	SocketPlugins.v2mm.removeTopicLabel = function (socket, data, callback) {
		if (!data || !data.value || !socket.uid) {
			return callback();
		}
		User.isAdministrator(socket.uid, function (err, isAdmin) {
			if (!isAdmin) {
				callback();
			}
			TopicLabel.remove(data, callback);
		});
	};

	SocketPlugins.v2mm.handleLabel = function (socket, data, callback) {
		if (!data || !data.tids || !data.tids.length || !socket.uid || !data.cid) {
			return callback();
		}
		var tids = data.tids;

		privileges.categories.isAdminOrMod(data.cid, socket.uid, function (err, isMod) {
			if (!isMod) {
				return callback(err);
			}
			async.each(tids, function (tid, next) {
				if (data.action === 'add'){
					TopicLabel.addToTopic(tid, data.label, next);
				} else if (data.action === 'remove') {
					TopicLabel.removeFromTopic(tid, data.label, next);
				} else if (data.action === 'removeAll') {
					TopicLabel.removeTopicLabels(tid, next);
				} else {
					next();
				}
			}, callback);
		});
	};

	function renderAdmin(req, res, next) {
		TopicLabel.getAvailabelLabels(function (err, data) {
			if (err) {
				return next(err);
			}
			res.render('admin/plugins/v2mm', {availabelLabels: data});
		});
	}

	module.exports = theme;

}(module));
