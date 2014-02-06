$('document').ready(function() {
	requirejs([
		'/css/assets/vendor/masonry.js',
	], function(Masonry) {
		$(document).bind('DOMNodeInserted', function(event) {
			// Unsure about performance of this, probably pretty bad. Need to bind to ajaxify.onchange or similar instead.
			if (event.target.className == 'row home') {
				if(!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
					setTimeout(function() {
						new Masonry('.row.home > div', {
							itemSelector: '.category-item',
							columnWidth: '.category-item',
						});
					}, 50);
				}


				// Copied from categories.js
				$.get(RELATIVE_PATH + '/api/recent/month', {}, function(posts) {
					var recentReplies = $('#category_recent_replies');

					if(!posts || !posts.topics || !posts.topics.length) {
						recentReplies.html('No topics have been posted yet.');
						return;
					}

					posts = posts.topics.slice(0, 8);

					var replies = '';

					for (var i = 0, numPosts = posts.length; i < numPosts; ++i) {
						var lastPostIsoTime = utils.toISOString(posts[i].lastposttime);

						replies += '<li data-pid="'+ posts[i].pid +'" class="clearfix">' +
									'<a href="' + RELATIVE_PATH + '/user/' + posts[i].teaser_userslug + '"><img title="' + posts[i].teaser_username + '" class="img-rounded user-img" src="' + posts[i].teaser_userpicture + '"/></a>' +
									'<p>' +
										'<strong><span>'+ posts[i].teaser_username + '</span></strong>' +
										'<span> [[global:posted]] [[global:in]] </span>' +
										'"<a href="' + RELATIVE_PATH + '/topic/' + posts[i].slug + '#' + posts[i].teaser_pid + '" >' + posts[i].title + '</a>"' +
									'</p>'+
									'<span class="pull-right">'+
										'<span class="timeago" title="' + lastPostIsoTime + '"></span>' +
									'</span>'+
									'</li>';
					}

					translator.translate(replies, function(translatedHtml) {
						recentReplies.html(translatedHtml);

						$('#category_recent_replies span.timeago').timeago();
						app.createUserTooltips();
					});
				});
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