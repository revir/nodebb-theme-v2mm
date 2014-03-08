$('document').ready(function() {
	requirejs([
		RELATIVE_PATH + '/css/assets/vendor/masonry.js',
		RELATIVE_PATH + '/css/assets/vendor/imagesLoaded.js',
	], function(Masonry, imagesLoaded) {
		$(window).on('action:ajaxify.end', function(ev, data) {
			var url = data.url;

			if (url === "") {
				if(!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
					var masonry = new Masonry('.row.home > div', {
						itemSelector: '.category-item',
						columnWidth: '.category-item',
					});

					$('.row.home > div').imagesLoaded(function() {
						masonry.layout();
					});
				}
			}
		});
	});

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