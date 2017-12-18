$('document').ready(function() {
	requirejs([
		'lavender/masonry',
		'lavender/imagesLoaded',
	], function(Masonry, imagesLoaded) {
		var fixed = localStorage.getItem('fixed') || 1,
			masonry;

		function doMasonry() {
			if($('.masonry').length) {
				masonry = new Masonry('.masonry', {
					itemSelector: '.category-item',
					columnWidth: '.category-item:not(.col-lg-12)',
					transitionDuration: 0,
					isInitLayout: false,
					isOriginLeft: $('html').attr('data-dir') === 'ltr',
				});

				$('.row.categories > div p img').imagesLoaded(function() {
					masonry.layout();
				});

				var saved = JSON.parse(localStorage.getItem('masonry:layout'));
				if (saved) {
					for (var cid in saved) {
						if (saved.hasOwnProperty(cid)) {
							var category = saved[cid];

							$('.category-item[data-cid="' + cid + '"]').css({
								left: category.left,
								top: category.top,
								position: 'absolute'
							});
						}
					}
				}

				masonry.on('layoutComplete', function() {
					var saved = {};

					$('.category-item').each(function() {
						var $this = $(this);

						saved[$this.attr('data-cid')] = {
							left: $this.css('left'),
							top: $this.css('top'),
						};
					});

					localStorage.setItem('masonry:layout', JSON.stringify(saved));
				});
			}
		}

		function resize(fixed) {
			fixed = parseInt(fixed, 10);

			var container = fixed ? $('.container-fluid') : $('.container');
			container.toggleClass('container-fluid', fixed !== 1).toggleClass('container', fixed === 1);
			localStorage.setItem('fixed', fixed);
		}

		resize(fixed);

		$(window).on('action:ajaxify.end', function(ev, data) {
			var url = data.url;

			if(!/^admin\//.test(data.url) && !/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
				doMasonry();
				if ($('.categories').length) {
					$('.category-header .badge i').tooltip();
				}
			}
		});

		if (!$('.admin').length) {
			setupResizer();
		}

		$(window).on('action:posts.loaded', function() {
			doMasonry();
		});

		function setupResizer() {
			var div = $('<div class="overlay-container"><div class="panel resizer pointer"><div class="panel-body"><i class="fa fa-arrows-h fa-2x"></i></div></div></div>');

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

			div.find('.resizer').on('click', function() {
				fixed = parseInt(fixed, 10) === 1 ? 0 : 1;
				resize(fixed);
				doMasonry();
			});
		}
	});


	var loadingBar = $('.loading-bar');
	var ajaxifyingEffect = $('.ajaxifying-effect');
	var oldColor = $("body").css('backgroundColor');

	$(window).on('action:ajaxify.start', function(data) {
		loadingBar.fadeIn(0).removeClass('reset');
		ajaxifyingEffect.removeClass('hidden');
		$("body").css('backgroundColor', '#303333');

		$('.navbar-header .post-wrapper').addClass('visible-xs-block').show();
	});

	$(window).on('action:ajaxify.loadingTemplates', function() {
		loadingBar.css('width', '90%');
	});

	$(window).on('action:ajaxify.contentLoaded', function() {
		loadingBar.css('width', '100%');
		ajaxifyingEffect.addClass('hidden');
		$("body").css('backgroundColor', oldColor);

		setTimeout(function() {
			loadingBar.fadeOut(250);

			setTimeout(function() {
				loadingBar.addClass('reset').css('width', '0%');
			}, 250);
		}, 750);
	});

	$(window).on('action:ajaxify.start', function() {
		if ($('.navbar .navbar-collapse').hasClass('in')) {
			$('.navbar-header .navbar-toggle').click();
		}
	});

	$(window).on('action:topic.loaded', function(evt, data) {
		if (data.postcount > 2) {
			$('.post-bar.hidden').removeClass('hidden');
		}
		$('.navbar-header .post-wrapper').removeClass('visible-xs-block').hide();

		if (app.user && (app.user.isAdmin || app.user.isGlobalMod || app.user.isMod)) {
			require(['forum/categoryTagsTools']);

			require(['forum/topicLabelsTool']);
		}
	});

	$('body').on('click', '.btn.new_topic', function () {
		app.newTopic();
	});

	$('body').on('click', '.chat-actions', function () {
		var $el = $(this);
		require(['forum/chats'], function(Chats) {
			var roomId = $el.data('roomid') || $el.closest('li').data('roomid');
			if ($el.hasClass('directly-open-chat')) {
				if (!ajaxify.currentPage.match(/^chats\//)) {
					app.openChat(roomId);
				} else {
					ajaxify.go('user/' + app.user.userslug + '/chats/' + roomId);
				}
			} else if ($el.hasClass('switch-room')){
				ajaxify.go('user/' + app.user.userslug + '/chats/' + roomId);
			} else if ($el.hasClass('leave-room')) {
				Chats.leave($el.closest('li'));
			}
		});
		return false;
	});

	$('body').on('click', 'a.topic-title.external-link', function () {
		$(this).closest('li.unread').removeClass('unread');
		var tid = $(this).data('tid');
		$.post('/api/v2mm/topic/'+tid+'/view');
	});

	$(window).on('action:profile.update', function (evt, userData) {
		$('.extra-site-control').each(function () {
			var site = this.id;
			userData[site] = this.value;
		});
	});

	// change icon-bar color on mobile when notification coming.
	$(window).on('action:notification.updateCount', function (evt, payload) {
		if (payload.count) {
			$('.navbar-header .navbar-toggle .icon-bar').css('background-color', 'red');
		} else {
			$('.navbar-header .navbar-toggle .icon-bar').css('background-color', '#ccc');
		}
	});

	$(window).on('action:category.loaded', function (evt, obj) {
		if (obj && obj.cid) {
			if (app.user && (app.user.isAdmin || app.user.isGlobalMod || app.user.isMod)) {
				require(['forum/categoryTagsTools']);
				require(['forum/topicLabelsTool']);
			}
		}
	});

	$(window).on('action:app.load', function (evt) {
		socket.emit('plugins.v2mm.getAllCategories', {}, function (err, categories) {
			app.parseAndTranslate('partials/categories_tree', {categories: categories}, function (html) {
				$('#dropdown-categories').addClass('dropdown-toggle');
				$('#dropdown-categories').parent().addClass("dropdown");
				$('#dropdown-categories').parent().append(html);
				$('#dropdown-categories').mouseenter(function () {
					setTimeout(function () {
						if ($('#dropdown-categories').is(':hover')) {
							$('#dropdown-categories').parent().addClass("open");
						}
					}, 200);

				});
				$('#dropdown-categories').parent().mouseleave(function () {
					setTimeout(function () {
						// check the mouse has leave the element for a moment.
						if(!$('#dropdown-categories').parent().is(":hover")) {
							$('#dropdown-categories').parent().removeClass("open");
						}
					}, 300);
				});
			});
		});
	});


	// $(window).on('action:infinitescroll.loadmore', function (evt, obj) {
	// 	$('.v2mm-loading-spin').removeClass('hidden');
	// });
});
