<div class="row categories" itemscope itemtype="http://www.schema.org/ItemList">
	<div class="col-lg-9 col-sm-12" no-widget-class="col-lg-12 col-sm-12" no-widget-target="sidebar">
		<div class="row <!-- IF !disableMasonry -->masonry<!-- ENDIF !disableMasonry -->">
			<!-- BEGIN categories -->
			<div component="categories/category" class="<!-- IF categories.class -->{categories.class}<!-- ELSE -->col-md-3 col-sm-6 col-xs-12<!-- ENDIF categories.class --> category-item" data-cid="{categories.cid}" data-numRecentReplies="{categories.numRecentReplies}">
				<meta itemprop="name" content="{categories.name}">

				<div class="category-icon">

					<!-- IF categories.link -->
					<a style="color: {categories.color};" href="{categories.link}" itemprop="url" target="_blank">
					<!-- ELSE -->
					<a style="color: {categories.color};" href="{config.relative_path}/category/{categories.slug}" itemprop="url">
					<!-- ENDIF categories.link -->
						<div
							id="category-{categories.cid}" class="category-header category-header-image-{categories.imageClass}"
							style="
								<!-- IF categories.backgroundImage -->background-image: url({categories.backgroundImage});<!-- ENDIF categories.backgroundImage -->
								<!-- IF categories.bgColor -->background-color: {categories.bgColor};<!-- ENDIF categories.bgColor -->
								color: {categories.color};
							"
						>
							<!-- IF !categories.link -->
							<span class="badge {categories.unread-class}"><i class="fa fa-book" data-toggle="tooltip" title="[[global:topics]]"></i> <span class="human-readable-number" title="{categories.totalTopicCount}">{categories.totalTopicCount}</span>&nbsp; <i class="fa fa-pencil" data-toggle="tooltip" title="[[global:posts]]"></i> <span class="human-readable-number" title="{categories.totalPostCount}">{categories.totalPostCount}</span></span>
							<!-- ENDIF !categories.link -->

							<!-- IF categories.icon -->
							<div><i class="fa {categories.icon} fa-4x"></i></div>
							<!-- ENDIF categories.icon -->
						</div>
					</a>

					<div class="category-box">
						<div class="category-info">
							<!-- IF categories.link -->
							<a href="{categories.link}" itemprop="url" target="_blank">
							<!-- ELSE -->
							<a href="{config.relative_path}/category/{categories.slug}" itemprop="url">
							<!-- ENDIF categories.link -->
								<h4><!-- IF categories.icon --><i class="fa {categories.icon} visible-xs-inline"></i> <!-- ENDIF categories.icon -->{categories.name}</h4>
							</a>
							<div class="description" itemprop="description">{categories.descriptionParsed}</div>
						</div>

						<!-- IF !categories.link -->
						<!-- BEGIN posts -->
						<div component="category/posts" class="post-preview clearfix">
							<strong><a href="{config.relative_path}/topic/{categories.posts.topic.slug}">{categories.posts.topic.title}</a></strong>
							<hr/>
							<a style="color: {categories.color};" href="<!-- IF categories.posts.user.userslug -->{config.relative_path}/user/{categories.posts.user.userslug}<!-- ELSE -->#<!-- ENDIF categories.posts.user.userslug -->">
								<!-- IF categories.posts.user.picture -->
								<img src="{categories.posts.user.picture}" title="{categories.posts.user.username}" class="pull-left user-img" />
								<!-- ELSE -->
								<div class="pull-left user-img user-icon" title="{categories.posts.user.username}" style="background-color: {categories.posts.user.icon:bgColor}">{categories.posts.user.icon:text}</div>
								<!-- ENDIF categories.posts.user.picture -->
							</a>
							<div class="post-preview-content">

								<div class="content">
								{categories.posts.content}
								</div>
								<p class="fade-out"></p>
							</div>

							<span class="pull-right post-preview-footer">
								<span class="timeago" title="{categories.posts.timestamp}"></span> &bull;
								<a href="{config.relative_path}/topic/{categories.posts.topic.slug}<!-- IF categories.posts.index -->/{categories.posts.index}<!-- ENDIF categories.posts.index -->">[[global:read_more]]</a>
							</span>
						</div>
						<!-- END posts -->
						<!-- ENDIF !categories.link -->
					</div>
				</div>
			</div>
			<!-- END categories -->
		</div>
	</div>

	<div widget-area="sidebar" class="col-lg-3 col-sm-12"></div>
</div>
