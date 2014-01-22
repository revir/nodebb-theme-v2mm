<ol class="breadcrumb">
	<li><a href="{relative_path}/">Home</a></li>
	<li class="active">Recent <a href="{relative_path}/recent.rss"><i class="fa fa-rss-square"></i></a></li>
</ol>

<ul class="nav nav-pills">
	<li class=''><a href='{relative_path}/recent/day'>[[recent:day]]</a></li>
	<li class=''><a href='{relative_path}/recent/week'>[[recent:week]]</a></li>
	<li class=''><a href='{relative_path}/recent/month'>[[recent:month]]</a></li>
</ul>

<br />

<a href="{relative_path}/recent">
	<div class="alert alert-warning hide" id="new-topics-alert"></div>
</a>

<div class="alert alert-warning hide {no_topics_message}" id="category-no-topics">
	<strong>There are no recent topics.</strong>
</div>

<div class="category row">
	<div class="col-md-12">
		<ul id="topics-container">
		<!-- BEGIN topics -->
		<li class="category-item {topics.deleted-class}" itemprop="itemListElement">
			<meta itemprop="name" content="{topics.title}">
			<div class="category-item">
				<div class="category-body">
					<div class="row">
						<div class="col-md-8 col-sm-9">
							<div class="category-profile-pic">
								<a href="{relative_path}/user/{topics.userslug}">
									<img src="{topics.picture}" alt="{topics.teaser_username}" class="profile-image user-img" title="{topics.username}">
								</a>
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
							<a href="../../user/{topics.teaser_userslug}"><img class="profile-image small user-img" src="{topics.teaser_userpicture}" title="{topics.teaser_username}"/></a>
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
	</div>
</div>
