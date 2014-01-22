<div class="row home" itemscope itemtype="http://www.schema.org/ItemList">
	<div class="col-lg-9 col-sm-12">
		<div class="row">
			<!-- BEGIN categories -->
			<div class="col-md-3 col-sm-6 col-xs-12 category-item">
				<meta itemprop="name" content="{categories.name}">

				<div class="category-icon">
					<div id="category-{categories.cid}" class="category-header hidden-xs" style="background: {categories.background}; color: {categories.color};">
						<span class="badge {categories.badgeclass}">{categories.topic_count} </span>
						<a style="color: {categories.color};" href="category/{categories.slug}" itemprop="url">
							<div><i class="fa {categories.icon} fa-4x"></i></div>
						</a>
					</div>
					<div class="category-box">
						<a href="category/{categories.slug}" itemprop="url">
							<h4><i class="fa {categories.icon} visible-xs-inline"></i> {categories.name}</h4>
						</a>
						<div class="description" itemprop="description">{categories.description}</div>
						<!-- BEGIN posts -->
						<div class="post-preview clearfix">
							<a style="color: {categories.color};" href="./user/{categories.posts.userslug}">
								<img src="{categories.posts.picture}" class="pull-left" />
							</a>

							<p>
								<strong>{categories.posts.username}</strong><br/>
								{categories.posts.content}
							</p>
							<span class="pull-right">
								<a href="topic/{categories.posts.topicSlug}#{categories.posts.pid}">posted </a>
								<span class="timeago" title="{categories.posts.relativeTime}"></span>
							</span>
						</div>
						<!-- END posts -->
					</div>
				</div>
			</div>
			<!-- END categories -->
		</div>
	</div>

	<div class="col-lg-3 col-sm-12 {show_sidebar} category category-sidebar">
		<div class="panel panel-default {motd_class}">
			<div class="panel-heading">MOTD</div>
			<div class="panel-body">
				<div class="motd">
					{motd}
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">[[category:sidebar.recent_replies]]</div>
			<div class="panel-body recent-replies">
				<ul id="category_recent_replies"></ul>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">Forum Stats</div>
			<div class="panel-body">
				<div class="row footer-stats">
					<div class="col-md-3 col-xs-6">
						<div class="stats-card">
							<h2><span id="stats_online"></span><br /><small>[[footer:stats.online]]</small></h2>
						</div>
					</div>
					<div class="col-md-3 col-xs-6">
						<div class="stats-card">
							<h2><span id="stats_users"></span><br /><small>[[footer:stats.users]]</small></h2>
						</div>
					</div>
					<div class="col-md-3 col-xs-6">
						<div class="stats-card">
							<h2><span id="stats_topics"></span><br /><small>[[footer:stats.topics]]</small></h2>
						</div>
					</div>
					<div class="col-md-3 col-xs-6">
						<div class="stats-card">
							<h2><span id="stats_posts"></span><br /><small>[[footer:stats.posts]]</small></h2>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
