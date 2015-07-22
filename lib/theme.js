(function(module) {
	"use strict";

	var theme = {},
		meta = module.parent.require('./meta'),
		path = module.parent.require('path'),
		nconf = module.parent.require('nconf');

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

		app.get('/admin/plugins/lavender', middleware.admin.buildHeader, renderAdmin);
		app.get('/api/admin/plugins/lavender', renderAdmin);

		callback();
	};

	theme.addAdminNavigation = function(header, callback) {
		header.plugins.push({
			route: '/plugins/lavender',
			icon: 'fa-paint-brush',
			name: 'Lavender Theme'
		});

		callback(null, header);
	};

	theme.getConfig = function(config, callback) {
		config.disableMasonry = !!parseInt(meta.config.disableMasonry, 10);
		callback(false, config);
	};

	function renderAdmin(req, res, next) {
		res.render('admin/plugins/lavender', {});
	}

	module.exports = theme;

}(module));