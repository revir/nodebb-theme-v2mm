<div class="<!-- IF children.class -->{children.class}<!-- ELSE -->col-md-3 col-sm-6 col-xs-12<!-- ENDIF children.class --> category-item" data-cid="{children.cid}" data-numRecentReplies="{children.numRecentReplies}">
	<meta itemprop="name" content="{children.name}">

	<div class="category-icon">

		<!-- IF children.link -->
		<a style="color: {children.color};" href="{children.link}" itemprop="url" target="_blank">
		<!-- ELSE -->
		<a style="color: {children.color};" href="{config.relative_path}/category/{children.slug}" itemprop="url">
		<!-- ENDIF children.link -->
			<div
				id="category-{children.cid}" class="category-header category-header-image-{children.imageClass}"
				style="
					<!-- IF children.backgroundImage -->background-image: url({children.backgroundImage});<!-- ENDIF children.backgroundImage -->
					<!-- IF children.bgColor -->background-color: {children.bgColor};<!-- ENDIF children.bgColor -->
					color: {children.color};
				"
			>
				<!-- IF !children.link -->
				<span class="badge {children.unread-class}"><i class="fa fa-book" data-toggle="tooltip" title="[[global:topics]]"></i> <span class="human-readable-number" title="{children.totalTopicCount}">{children.totalTopicCount}</span>&nbsp; <i class="fa fa-pencil" data-toggle="tooltip" title="[[global:posts]]"></i> <span class="human-readable-number" title="{children.totalPostCount}">{children.totalPostCount}</span></span>
				<!-- ENDIF !children.link -->

				<!-- IF children.icon -->
				<div><i class="fa {children.icon} fa-4x"></i></div>
				<!-- ENDIF children.icon -->
			</div>
		</a>

		<div class="category-box">
			<div class="category-info">
				<!-- IF children.link -->
				<a href="{children.link}" itemprop="url" target="_blank">
				<!-- ELSE -->
				<a href="{config.relative_path}/category/{children.slug}" itemprop="url">
				<!-- ENDIF children.link -->
					<h4><!-- IF children.icon --><i class="fa {children.icon} visible-xs-inline"></i> <!-- ENDIF children.icon -->{children.name}</h4>
				</a>
				<div class="description" itemprop="description">{children.description}</div>
			</div>
			<!-- IF !children.link -->
			<!-- BEGIN posts -->
			<div class="post-preview clearfix">
				<div class="post-preview-content">
					<strong><a href="{config.relative_path}/topic/{children.posts.topic.slug}">{children.posts.topic.title}</a></strong>
					<hr/>
					<a style="color: {children.color};" href="<!-- IF children.posts.user.userslug -->{config.relative_path}/user/{children.posts.user.userslug}<!-- ELSE -->#<!-- ENDIF children.posts.user.userslug -->">
						<!-- IF children.posts.user.picture -->
						<img src="{children.posts.user.picture}" title="{children.posts.user.username}" class="pull-left user-img" />
						<!-- ELSE -->
						<div class="pull-left user-img user-icon" title="{children.posts.user.username}" style="background-color: {children.posts.user.icon:bgColor}">{children.posts.user.icon:text}</div>
						<!-- ENDIF children.posts.user.picture -->
					</a>
					<div class="content">
					{children.posts.content}
					</div>
					<p class="fade-out"></p>
				</div>
				<span class="pull-right post-preview-footer">
					<span class="timeago" title="{children.posts.timestampISO}"></span> &bull;
					<a href="{config.relative_path}/topic/{children.posts.topic.slug}<!-- IF children.posts.index -->/{children.posts.index}<!-- ENDIF children.posts.index -->">[[global:read_more]]</a>
				</span>
			</div>
			<!-- END posts -->
			<!-- ENDIF !children.link -->
		</div>
	</div>
</div>
