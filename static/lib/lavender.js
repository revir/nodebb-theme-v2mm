$('document').ready(function() {


	(function() {
		// loading animation
		var ajaxifyGo = ajaxify.go,
			loadTemplates = templates.load_template,
			refreshTitle = app.refreshTitle,
			loadingBar = $('.loading-bar');

		ajaxify.go = function(url, callback, quiet) {
			loadingBar.addClass('reset').css('width', '100%');
			return ajaxifyGo(url, callback, quiet);
		};

		templates.load_template = function(callback, url, template) {
			setTimeout(function() {
				loadingBar.removeClass('reset').css('width', (Math.random() * 25) + 5 + '%');
			}, 10);

			return loadTemplates(callback, url, template);
		};

		app.refreshTitle = function(url) {
			setTimeout(function() {
				loadingBar.css('width', '0%');
			}, 300);

			return refreshTitle(url);
		};
	}());
});