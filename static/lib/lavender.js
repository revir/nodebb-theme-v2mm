$('document').ready(function() {
	requirejs([
		'/css/assets/vendor/masonry.js',
	], function(Masonry) {
		$(document).bind('DOMNodeInserted', function(event) {
			// Unsure about performance of this, probably pretty bad. Need to bind to ajaxify.onchange or similar instead.
			if (event.target.className == 'row home') {
				setTimeout(function() {
					new Masonry('.row.home > div', {	
						itemSelector: '.category-item',
						columnWidth: '.category-item',
					});
				}, 50);

				// Copied from categories.js
				var li = document.createElement('li'),
					recent_replies = document.getElementById('category_recent_replies'),
					frag = document.createDocumentFragment();

				$.get(RELATIVE_PATH + '/api/recent/month', {}, function(posts) {
					posts = posts.topics;

					for (var i = 0, numPosts = posts.length; i < numPosts; i++) {
						li.setAttribute('data-pid', posts[i].pid);
						li.innerHTML = '<a href="' + RELATIVE_PATH + '/user/' + posts[i].teaser_userslug + '"><img title="' + posts[i].teaser_username + '" class="img-rounded user-img" src="' + posts[i].teaser_userpicture + '"/></a>' +
							'<a href="' + RELATIVE_PATH + '/topic/' + posts[i].slug + '#' + posts[i].teaser_pid + '">' +
							'<strong><span>'+ posts[i].teaser_username + '</span></strong> posted in' +
							'<p>' +
							posts[i].title +
							'</p>' +
							'</a>' +
							'<span class="timeago pull-right" title="' + posts[i].relativeTime + '"></span>';

						frag.appendChild(li.cloneNode(true));
						recent_replies.appendChild(frag);
					}
					$('#category_recent_replies span.timeago').timeago();
					app.createUserTooltips();
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