<div class="row home" itemscope itemtype="http://www.schema.org/ItemList">
	<div class="col-lg-9 col-sm-12" no-widget-class="col-lg-12 col-sm-12" no-widget-target="sidebar">
		<div class="row">
			<!-- BEGIN categories -->
			<div class="col-md-3 col-sm-6 col-xs-12 category-item" data-cid="{categories.cid}" data-numRecentReplies="{categories.numRecentReplies}">
				<meta itemprop="name" content="{categories.name}">

				<div class="category-icon">

					<!-- IF categories.link -->
					<a style="color: {categories.color};" href="{categories.link}" itemprop="url" target="_blank">
					<!-- ELSE -->
					<a style="color: {categories.color};" href="{relative_path}/category/{categories.slug}" itemprop="url">
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
							<span class="badge {categories.unread-class}">{categories.topic_count} </span>
							<!-- ENDIF !categories.link -->

							<div><i class="fa {categories.icon} fa-4x"></i></div>
						</div>
					</a>

					<div class="category-box">
						<!-- IF categories.link -->
						<a href="{categories.link}" itemprop="url" target="_blank">
						<!-- ELSE -->
						<a href="{relative_path}/category/{categories.slug}" itemprop="url">
						<!-- ENDIF categories.link-->
							<h4><i class="fa {categories.icon} visible-xs-inline"></i> {categories.name}</h4>
						</a>
						<div class="description" itemprop="description">{categories.description}</div>
						<!-- IF !categories.link -->
						<!-- BEGIN posts -->
						<div class="post-preview clearfix">
							<a style="color: {categories.color};" href="./user/{categories.posts.user.userslug}">
								<img src="{categories.posts.user.picture}" title="{categories.posts.user.username}" class="pull-left user-img" />
							</a>

							<p>
								<strong>{categories.posts.user.username}</strong><br/>
								{categories.posts.content}
							</p>
							<span class="pull-right">
								<a href="topic/{categories.posts.topic.slug}#{categories.posts.pid}">[[category:posted]]</a>
								<span class="timeago" title="{categories.posts.relativeTime}"></span>
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

	<div widget-area="sidebar" class="col-lg-3 col-sm-12 hidden"></div>
</div>
