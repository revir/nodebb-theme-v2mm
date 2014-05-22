$('document').ready(function() {
	requirejs([
		RELATIVE_PATH + '/css/assets/vendor/masonry.js',
		RELATIVE_PATH + '/css/assets/vendor/imagesLoaded.js',
	], function(Masonry, imagesLoaded) {
		var fixed = localStorage.getItem('fixed') || 0,
			masonry;

		function doMasonry() {
			if($('.home').length) {
				masonry = new Masonry('.row.home > div', {
					itemSelector: '.category-item',
					columnWidth: '.category-item'
				});

				$('.row.home > div p img').imagesLoaded(function() {
					masonry.layout();
				});
			}
		}

		function resize(fixed) {
			fixed = parseInt(fixed, 10);
			var container = $('.container').length ? $('.container') : $('.container-fluid');
			container.toggleClass('container-fluid', fixed !== 1).toggleClass('container', fixed === 1);

			localStorage.setItem('fixed', fixed);
			doMasonry();
		}

		$(window).on('action:ajaxify.end', function(ev, data) {
			var url = data.url;

			if(!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
				if (url === "") {
					doMasonry();
					$('.category-header .badge i').tooltip();
				}

				resize(fixed);
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
			fixed = parseInt(fixed, 10) === 1 ? 0 : 1;
			resize(fixed);
		});
	});

	(function() {
		// loading animation
		var ajaxifyGo = ajaxify.go,
			loadData = ajaxify.loadData,
			refreshTitle = app.refreshTitle,
			loadingBar = $('.loading-bar');

		ajaxify.go = function(url, callback, quiet) {
			loadingBar.addClass('reset').css('width', '100%');
			return ajaxifyGo(url, callback, quiet);
		};

		ajaxify.loadData = function(callback, url, template) {
			setTimeout(function() {
				loadingBar.removeClass('reset').css('width', (Math.random() * 20) + 5 + '%');
			}, 10);

			return loadData(callback, url, template);
		};

		app.refreshTitle = function(url) {
			setTimeout(function() {
				loadingBar.css('width', '0%');
			}, 300);

			return refreshTitle(url);
		};
	}());
});