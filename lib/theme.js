(function(module) {
	"use strict";

	var theme = {},
		meta = module.parent.require('./meta');

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