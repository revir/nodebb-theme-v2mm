<div class="motd{motd_class}">
	{motd}
</div>

<div class="row home" itemscope itemtype="http://www.schema.org/ItemList">
	<!-- BEGIN categories -->
	<div class="col-lg-2 col-md-3 col-sm-6 col-xs-12 category-item">
		<meta itemprop="name" content="{categories.name}">
		
		<div class="category-icon">
			<div id="category-{categories.cid}" class="category-header" style="background: {categories.background}; color: {categories.color};">
				<span class="badge {categories.badgeclass}">{categories.topic_count} </span>
				<a style="color: {categories.color};" href="category/{categories.slug}" itemprop="url">
					<div><i class="fa {categories.icon} fa-4x"></i></div>
				</a>
			</div>
			<div class="category-box">
				<a href="category/{categories.slug}" itemprop="url">
					<h4>{categories.name}</h4>
				</a>
				<div class="description" itemprop="description">{categories.description}</div>
				<!-- BEGIN posts -->
				<div class="post-preview">
					<a style="color: {categories.color};" href="./user/{categories.posts.userslug}"><img src="{categories.posts.picture}" class="pull-left" /></a>
					<p><a href="topic/{categories.posts.topicSlug}#{categories.posts.pid}">{categories.posts.content}</a> - {categories.posts.username}, <span class="timeago" title="{categories.posts.relativeTime}"></span></p>
				</div>
				<!-- END posts -->
			</div>
		</div>
	</div>
	<!-- END categories -->
</div>

<div class="row footer-stats">
	<div class="col-md-3 col-xs-6">
		<div class="stats-card well">
			<h2><span id="stats_online"></span><br /><small>[[footer:stats.online]]</small></h2>
		</div>
	</div>
	<div class="col-md-3 col-xs-6">
		<div class="stats-card well">
			<h2><span id="stats_users"></span><br /><small>[[footer:stats.users]]</small></h2>
		</div>
	</div>
	<div class="col-md-3 col-xs-6">
		<div class="stats-card well">
			<h2><span id="stats_topics"></span><br /><small>[[footer:stats.topics]]</small></h2>
		</div>
	</div>
	<div class="col-md-3 col-xs-6">
		<div class="stats-card well">
			<h2><span id="stats_posts"></span><br /><small>[[footer:stats.posts]]</small></h2>
		</div>
	</div>
</div>