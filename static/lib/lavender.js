'use strict';

/* globals requirejs, RELATIVE_PATH, ajaxify, templates, app */

$('document').ready(function() {
	requirejs([
		RELATIVE_PATH + '/css/assets/vendor/masonry.js',
		RELATIVE_PATH + '/css/assets/vendor/imagesLoaded.js',
	], function(Masonry, imagesLoaded) {
		var fixed = localStorage.getItem('fixed') || 0;
		fixed = parseInt(fixed, 10);

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

		function onTransitionEnd() {
			localStorage.setItem('fixed', fixed);
			doMasonry();
		}

		function resize() {
			$('.container').off('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', onTransitionEnd)
				.on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', onTransitionEnd);

			if (fixed !== 1) {
				$('.container').css('width', '95%');
			} else {
				$('.container').removeAttr('style');
			}
		}

		$(window).on('action:ajaxify.end', function(ev, data) {
			var url = data.url;

			if (url === '') {
				if(!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
					resize();
				}
			}
		});

		var div = $('<div class="panel resizer pointer"><div class="panel-body"><i class="fa fa-bars fa-2x"></i></div></div>');
		div.css({
			position:'fixed',
			bottom: '20px',
			right: '20px'
		}).hide().appendTo(document.body);

		$(window).on('mousemove', function(ev) {
			if (ev.clientX > $(window).width() - 150 && ev.clientY > $(window).height() - 150) {
				div.fadeIn();
			} else {
				div.stop(true, true).fadeOut();
			}
		});

		div.on('click', function() {
			fixed = fixed === 1 ? 0 : 1;
			resize(fixed);
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