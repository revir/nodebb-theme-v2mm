(function(module) {
	"use strict";

	var theme = {},
		meta = module.parent.require('./meta'),
		path = module.parent.require('path'),
		nconf = module.parent.require('nconf');

	var topics = require.main.require('./src/topics');
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

	theme.setExternalLinkOnSaveTopic = function(obj, callback){
		// match url content, if it starts with http.
		// note: \u4e00-\u9fa5 is match chinese; % is match encoded URL.
		var m = /^https?:\/\/([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.#%+-_\u4e00-\u9fa5]*)*$/;
		var content = obj.data.content.trim();
		var groups = content.split(/\n/);
		var c = groups[0].trim().match(m);
		if (c) {
			obj.topic.externalLink = c[0];
			groups.splice(0, 1);
			var comment = groups.join('\n').trim();
			if (comment) {
				obj.topic.externalComment = comment;
			}
		}
		return callback(false, obj);
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

		return controller_helpers.redirect(res, externalUrl);
	}

	function renderAdmin(req, res, next) {
		res.render('admin/plugins/lavender', {});
	}

	module.exports = theme;

}(module));
