<div class="unread">
	<ol class="breadcrumb">
		<li><a href="{relative_path}/">[[global:home]]</a></li>
		<li class="active">{category_name}</li>
	</ol>

	<div class="alert alert-warning {no_topics_message}" id="category-no-topics">
		<strong>[[unread:no_unread_topics]]</strong>
	</div>

	<button id="mark-allread-btn" class="btn btn-primary {show_markallread_button}">[[unread:mark_all_read]]</button>

	<a href="{relative_path}/unread">
		<div class="alert alert-warning hide" id="new-topics-alert"></div>
	</a>

	<div class="category row">
		<div class="col-md-12">
			<ul id="topics-container" data-next-start="{nextStart}">
			<!-- BEGIN topics -->
			<li class="category-item {topics.deleted-class}" itemprop="itemListElement">
				<meta itemprop="name" content="{topics.title}">
				<div class="category-item">
					<div class="category-body">
						<div class="row">
							<div class="col-md-8 col-sm-9">
								<div class="category-profile-pic">
									<img src="{topics.picture}" alt="{topics.teaser_username}" class="profile-image">
								</div>
								<div class="category-text">
									<p><strong><i class="fa {topics.pin-icon}"></i> <i class="fa {topics.lock-icon}"></i></strong>
										<a href="../../topic/{topics.slug}" itemprop="url">{topics.title}</a><br />
										<small>[[category:posted]] <span class="timeago" title="{topics.relativeTime}"></span> by {topics.username}</small>
									</p>
								</div>
							</div>
							<div class="col-xs-1 category-stat hidden-xs">
								<strong class="human-readable-number" title="{topics.postcount}">{topics.postcount}</strong><br />
								<small>[[category:posts]]</small>
							</div>
							<div class="col-xs-1 category-stat hidden-xs">
								<strong class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</strong><br />
								<small>[[category:views]]</small>
							</div>
							<div class="col-xs-2 category-stat replies hidden-sm hidden-xs">
								<!-- IF topics.unreplied -->
								<p class="no-replies">[[category:no_replies]]</p>
								<!-- ELSE -->
								<a href="../../user/{topics.teaser_userslug}">
									<img class="profile-image small" src="{topics.teaser_userpicture}" title="{topics.teaser_username}"/>
								</a>
								<a href="../../topic/{topics.slug}#{topics.teaser_pid}">
									[[category:replied]]
									<span class="timeago" title="{topics.teaser_timestamp}"></span>
								</a>
								<!-- ENDIF topics.unreplied -->
							</div>
						</div>
					</div>
				</div>
			</li>
			<!-- END topics -->
			</ul>
			<button id="load-more-btn" class="btn btn-primary hide">[[unread:load_more]]</button>
		</div>
	</div>
</div>
