$('document').ready(function() {
	requirejs([
		'/css/assets/vendor/masonry.js',
		'/css/assets/vendor/imagesLoaded.js',
	], function(Masonry, imagesLoaded) {

		function doMasonry() {
			if($('.home').length) {
				var masonry = new Masonry('.row.home > div', {
					itemSelector: '.category-item',
					columnWidth: '.category-item',
				});

				$('.row.home > div').imagesLoaded(function() {
					masonry.layout();
				});
			}
		}

		function resize(fluid) {
			$('.container').animate({
				width: parseInt(fluid, 10) === 1 ? '95%' : '1280px'
			}, function() {
				localStorage.setItem('fluid', fluid);
				doMasonry();
			});
		}

		$(window).on('action:ajaxify.end', function(ev, data) {
			var url = data.url;

			if (url === "") {
				if(!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
					doMasonry();
				}
			}
		});

		var div = $('<div class="panel resizer"><div class="panel-body"><i class="fa fa-bars fa-2x"></i></div></div>');
		div.css({
			position:'fixed',
			bottom: '20px',
			right: '20px'
		}).hide().appendTo(document.body);

		$(window).on('mousemove', function(ev) {
			if (ev.pageX > $(window).width() - 150 && ev.pageY > $(window).height() - 150) {
				div.fadeIn();
			} else {
				div.stop(true, true).fadeOut();
			}
		});

		var fluid = localStorage.getItem('fluid');
		resize(fluid);
		div.on('click', function() {
			fluid = parseInt(fluid, 10) === 1 ? 0 : 1;
			resize(fluid);
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