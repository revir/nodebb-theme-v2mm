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
	var SocketPlugins = require.main.require('./src/socket.io/plugins');
	var TopicLabel = require('./label');
	var User = require.main.require('./src/user');
	var privileges = require.main.require('./src/privileges');

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
				} else if (!externalAuthorName) {
					return callback(new Error('[[v2mm:no-externalAuthorName]]'));
				} else if (!externalAuthorLink) {
					return callback(new Error('[[v2mm:no-externalAuthorLink]]'));
				} else if (externalComment.length < 42) {
					// limit description length must be bigger than 42, TODO, move it to admin setting.
					return callback(new Error('[[v2mm:description_length_check]]'));
				} else {
					//TODO: externalComment should remove now, since it cannot be parsed as markdown, use teaser instead.
					obj.topic.externalLink = externalLink;
					obj.topic.externalAuthorLink = externalAuthorLink;
					obj.topic.externalAuthorName = externalAuthorName;
					obj.topic.externalComment = externalComment;
					return callback(false, obj);
				}

			} else {
				if (obj.data.externalLink) {
					// save externalLink and externalComment passed from api call, see nodebb-plugin-blog-comments2
					obj.topic.externalLink = obj.data.externalLink;
				} else {
					externalLink = matchUrl(groups[0]);
					if (externalLink) {
						obj.topic.externalLink = externalLink;
						groups.splice(0, 1);
						var description = groups.join('').trim();

						// limit description length must be bigger than 42, TODO, move it to admin setting.
						if (description.length < 42) {
							return callback(new Error('[[v2mm:description_length_check]]'));
						}
					} else {
						if (content.length < 42) {
							return callback(new Error('[[v2mm:description_length_check]]'));
						}
					}
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

	theme.onPurgeTopic = function (tid) {
		TopicLabel.removeTopicLabels(tid, function () {
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
	SocketPlugins.v2mm.goExternal = function (socket, data, callback) {
		 if (!data || !data.tid || !socket.uid) {
		 	return callback();
		 }

		 topics.markAsRead([data.tid], socket.uid, function(err, markedRead) {
		 	if (err) {
		 		return callback(err);
		 	}
		 	if (markedRead) {
		 		topics.pushUnreadCount(socket.uid);
		 		topics.markTopicNotificationsRead([data.tid], socket.uid);
		 	}
		 	return callback(err);
		 });
	};

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
		User.isAdministrator(socket.uid, function (isAdmin) {
			if (!isAdmin) {
				callback();
			}
			TopicLabel.create(data.value, data, socket.uid, callback);
		});
		
	};

	SocketPlugins.v2mm.removeTopicLabel = function (socket, data, callback) {
		if (!data || !data.value || !socket.uid) {
			return callback();
		}
		User.isAdministrator(socket.uid, function (isAdmin) {
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
