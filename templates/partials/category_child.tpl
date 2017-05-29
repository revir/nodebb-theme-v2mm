<div component="categories/category" class="<!-- IF ../class -->{../class}<!-- ELSE -->col-md-3 col-sm-6 col-xs-12<!-- ENDIF ../class --> category-item" data-cid="{../cid}" data-numRecentReplies="{../numRecentReplies}">
	<meta itemprop="name" content="{../name}">

	<div class="category-icon">

		<!-- IF ../link -->
		<a style="color: {../color};" href="{../link}" itemprop="url" target="_blank">
		<!-- ELSE -->
		<a style="color: {../color};" href="{config.relative_path}/category/{../slug}" itemprop="url">
		<!-- ENDIF ../link -->
			<div
				id="category-{../cid}" class="category-header category-header-image-{../imageClass}"
				style="
					<!-- IF ../backgroundImage -->background-image: url({../backgroundImage});<!-- ENDIF ../backgroundImage -->
					<!-- IF ../bgColor -->background-color: {../bgColor};<!-- ENDIF ../bgColor -->
					color: {../color};
				"
			>
				<!-- IF !../link -->
				<span class="badge {../unread-class}"><i class="fa fa-book" data-toggle="tooltip" title="[[global:topics]]"></i> <span class="human-readable-number" title="{../totalTopicCount}">{../totalTopicCount}</span>&nbsp; <i class="fa fa-pencil" data-toggle="tooltip" title="[[global:posts]]"></i> <span class="human-readable-number" title="{../totalPostCount}">{../totalPostCount}</span></span>
				<!-- ENDIF !../link -->

				<!-- IF ../icon -->
				<div><i class="fa {../icon} fa-4x"></i></div>
				<!-- ENDIF ../icon -->
			</div>
		</a>

		<div class="category-box">
			<div class="category-info">
				<!-- IF ../link -->
				<a href="{../link}" itemprop="url" target="_blank">
				<!-- ELSE -->
				<a href="{config.relative_path}/category/{../slug}" itemprop="url">
				<!-- ENDIF ../link -->
					<h4><!-- IF ../icon --><i class="fa {../icon} visible-xs-inline"></i> <!-- ENDIF ../icon -->{../name}</h4>
				</a>
				<div class="description" itemprop="description">{../descriptionParsed}</div>
			</div>

			<!-- IF !../link -->
			<!-- BEGIN posts -->
			<div component="category/posts" class="post-preview clearfix">
				<strong><a href="{config.relative_path}/topic/{../topic.slug}">{../topic.title}</a></strong>
				<hr/>
				<a style="color: {../color};" href="<!-- IF ../user.userslug -->{config.relative_path}/user/{../user.userslug}<!-- ELSE -->#<!-- ENDIF ../user.userslug -->">
					<!-- IF ../user.picture -->
					<img src="{../user.picture}" title="{../user.username}" class="pull-left user-img" />
					<!-- ELSE -->
					<div class="pull-left user-img user-icon" title="{../user.username}" style="background-color: {../user.icon:bgColor}">{../user.icon:text}</div>
					<!-- ENDIF ../user.picture -->
				</a>
				<div class="post-preview-content">

					<div class="content">
					{../content}
					</div>
					<p class="fade-out"></p>
				</div>

				<span class="pull-right post-preview-footer">
					<span class="timeago" title="{../timestampISO}"></span> &bull;
					<a href="{config.relative_path}/topic/{../topic.slug}<!-- IF ../index -->/{../index}<!-- ENDIF ../index -->">[[global:read_more]]</a>
				</span>
			</div>
			<!-- END posts -->
			<!-- ENDIF !../link -->
		</div>
	</div>
</div>