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
				name: "Category Header",
				template: "category.tpl",
				location: "header"
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
				name: "Recent Header",
				template: "recent.tpl",
				location: "header"
			},
			{
				name: "Tags Sidebar",
				template: "tags.tpl",
				location: "sidebar"
			},
			{
				name: "Tags Header",
				template: "tags.tpl",
				location: "header"
			},
			{
				name: "Tags Footer",
				template: "tags.tpl",
				location: "footer"
			},
			{
				name: "Popular Sidebar",
				template: "popular.tpl",
				location: "sidebar"
			},
			{
				name: "Popular Header",
				template: "popular.tpl",
				location: "header"
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
				name: "Unread Footer",
				template: "unread.tpl",
				location: "footer"
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
		var cid = obj.data.cid || obj.topic.cid;
		var externalLink = obj.data.externalLink;
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
					//TODO: externalComment should remove now, since it cannot be parsed as markdown, use teaser instead.
					obj.topic.externalLink = externalLink;
					obj.topic.isInternalLink = externalLink.indexOf(nconf.url) === 0;
					obj.topic.externalAuthorLink = externalAuthorLink;
					obj.topic.externalAuthorName = externalAuthorName;
					obj.topic.externalComment = externalComment;
					return callback(false, obj);
				}

			} else {
				if (!externalLink) {
					externalLink = matchUrl(groups[0]);
					if (externalLink) {
						obj.topic.externalLink = externalLink;
						obj.topic.isInternalLink = externalLink.indexOf(nconf.url) === 0;

					}
				} else {
					// save externalLink and externalComment passed from api call, see nodebb-plugin-blog-comments2
					obj.topic.externalLink = externalLink;
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

	theme.fixExternalTopicTeaser = function (data, callback) {
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
	};

	theme.saveTopicToRootCategory = function(topicData){
		getRootCategoryId(topicData.cid, function(err, rootCid){
			if (!err && rootCid) {
				db.sortedSetAdd('cid:' + rootCid + ':tids', topicData.timestamp, topicData.tid);
				db.incrObjectField('category:' + rootCid, 'topic_count');
				categories.updateRecentTid(rootCid, topicData.tid);
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

			return controller_helpers.redirect(res, decodeURIComponent(externalLink));
		});
	}

	function renderAdmin(req, res, next) {
		res.render('admin/plugins/lavender', {});
	}

	module.exports = theme;

}(module));
