(function(module) {
	"use strict";

	var theme = {},
		meta = module.parent.require('./meta'),
		path = module.parent.require('path'),
		nconf = module.parent.require('nconf'),
		async = module.parent.require('async');

	var topics = require.main.require('./src/topics');
	var Posts = require.main.require('./src/posts');
	var categories = require.main.require('./src/categories');
	var controller_helpers = require.main.require('./src/controllers/helpers');
	var db = require.main.require('./src/database');

	theme.defineWidgetAreas = function(areas, callback) {
		areas = areas.concat([
			{
				name: "Categories Sidebar",
				template: "categories.tpl",
				location: "sidebar"
			},
			{
				name: "Category Sidebar",
				template: "category.tpl",
				location: "sidebar"
			},
			{
				name: "Topic Sidebar",
				template: "topic.tpl",
				location: "sidebar"
			},
			{
				name: "Recent Sidebar",
				template: "recent.tpl",
				location: "sidebar"
			},
			{
				name: "Tags Sidebar",
				template: "tags.tpl",
				location: "sidebar"
			},
			{
				name: "Popular Sidebar",
				template: "popular.tpl",
				location: "sidebar"
			},
			{
				name: "Users Sidebar",
				template: "users.tpl",
				location: "sidebar"
			},
			{
				name: "Unread Sidebar",
				template: "unread.tpl",
				location: "sidebar"
			},
			{
				name: "Group List Sidebar",
				template: "groups/list.tpl",
				location: "sidebar"
			}
		]);

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

		app.get('/external_topic', goExternal);
		app.get('/api/external_topic', goExternal);

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

	function matchUrl(text) {
		// match url content, if it starts with http.
		// note: \u4e00-\u9fa5 is match chinese; % is match encoded URL.
		var m = /^https?:\/\/([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.&#%+-_\u4e00-\u9fa5]*)*$/;
		var c = text.trim().match(m);
		if (c) {
			return c[0];
		}
	}

	theme.setExternalLinkOnSaveTopic = function(obj, callback){
		var content = obj.data.content.trim();
		var cid = obj.data.cid;
		var externalLink;
		categories.getCategoryField(cid, 'isCustom', function(err, isCustom){
			if (err) {
				return callback(err, obj);
			}
			var groups = content.split(/\n/);

			if (isCustom) {
				var commentOut=0, withinComment=true;
				var externalAuthorLink, externalAuthorName, externalComment;
				var descStart = 0;
				for (var i = 0; i < groups.length; i++) {
					var text = groups[i].trim();
					if (withinComment && (!text || text.indexOf('//') === 0)){
						commentOut += 1;
					} else {
						withinComment = false;
						var m = text.match(/^官网URL：(.+)$/);
						if (m && m[1] && !externalLink) {
							externalLink = matchUrl(m[1]);
							descStart = i;
						} else {
							m = text.match(/^作者名字：(.+)$/);
							if (m && m[1] && !externalAuthorName) {
								externalAuthorName = m[1].trim();
								descStart = i;
							} else {
								m = text.match(/^作者URL：(.+)$/);
								if (m && m[1] && !externalAuthorLink) {
									externalAuthorLink = matchUrl(m[1]);
									descStart = i;
								}
							}
						}
					}
				}
				if (descStart && externalLink) {
					externalComment = groups.reduce(function(pre,cur,index){
						if (index <= descStart) {
							return '';
						} else {
							return pre+'\n'+cur;
						}
					});
					externalComment = externalComment.trim();
				}
				if (commentOut) {
					groups.splice(0, commentOut);
					obj.data.content = groups.join('\n').trim();
				}

				if (!externalLink) {
					return callback(new Error('[[v2mm:no-externalLink]]'));
				} else {
					obj.topic.externalLink = externalLink;
					obj.topic.externalAuthorLink = externalAuthorLink;
					obj.topic.externalAuthorName = externalAuthorName;
					obj.topic.externalComment = externalComment;
					return callback(false, obj);
				}

			} else {
				externalLink = matchUrl(groups[0]);
				if (externalLink) {
					groups.splice(0, 1);
					obj.topic.externalLink = externalLink;
					obj.topic.externalComment = groups.join('\n').trim();

				}
				return callback(false, obj);
			}
		});
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

	theme.saveTopicToRootCategory = function(topicData){
		getRootCategoryId(topicData.cid, function(err, pid){
			if (!err && pid) {
				console.log("pid: ", pid);
				var rootCid = pid;
				db.sortedSetAdd('cid:' + rootCid + ':tids', topicData.timestamp, topicData.tid);
				db.incrObjectField('category:' + rootCid, 'topic_count');
				categories.updateRecentTid(rootCid, topicData.tid);
			}
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

	function goExternal(req, res, next) {
		var externalUrl = req.query.link;
		var tid = req.query.tid;

		if (!tid || !externalUrl) {
			return next();
		}

		topics.getTopicField(tid, 'externalLink', function(err, externalLink){
			if (err) {
				return next(err);
			}
			req.session.tids_viewed = req.session.tids_viewed || {};
			if (!req.session.tids_viewed[tid] || req.session.tids_viewed[tid] < Date.now() - 3600000) {
				topics.increaseViewCount(tid);
				req.session.tids_viewed[tid] = Date.now();
			}

			if (req.uid) {
				topics.markAsRead([tid], req.uid, function(err, markedRead) {
					if (err) {
						return next(err);
					}
					if (markedRead) {
						topics.pushUnreadCount(req.uid);
						topics.markTopicNotificationsRead([tid], req.uid);
					}
				});
			}

			return controller_helpers.redirect(res, externalLink);
		});
	}

	function renderAdmin(req, res, next) {
		res.render('admin/plugins/lavender', {});
	}

	module.exports = theme;

}(module));
