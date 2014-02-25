<ol class="breadcrumb">
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
		<a href="{relative_path}/" itemprop="url"><span itemprop="title">[[global:home]]</span></a>
	</li>
	<li class="active" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
		<span itemprop="title">{category_name} <a target="_blank" href="../{category_id}.rss"><i class="fa fa-rss-square"></i></a></span>
	</li>
</ol>

<div>
	<!-- IF privileges.write -->
	<button id="new_post" class="btn btn-primary">[[category:new_topic_button]]</button>
	<!-- ENDIF privileges.write -->
	<!-- IF !disableSocialButtons -->
	<div class="inline-block pull-right">
		<a href="#" id="facebook-share"><i class="fa fa-facebook-square fa-2x"></i></a>&nbsp;
		<a href="#" id="twitter-intent"><i class="fa fa-twitter-square fa-2x"></i></a>&nbsp;
		<a href="#" id="google-share"><i class="fa fa-google-plus-square fa-2x"></i></a>&nbsp;
	</div>
	<!-- ENDIF !disableSocialButtons -->
</div>

<hr/>

<!-- IF !topics.length -->
<div class="alert alert-warning" id="category-no-topics">
	[[category:no_topics]]
</div>
<!-- ENDIF !topics.length -->

<div class="category row">
	<div class="{topic_row_size}" no-widget-class="col-lg-12 col-sm-12">
		<ul id="topics-container" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}">
			<meta itemprop="itemListOrder" content="descending">
			<!-- BEGIN topics -->
			<li class="category-item <!-- IF topics.deleted --> deleted<!-- ENDIF topics.deleted --><!-- IF topics.unread --> unread<!-- ENDIF topics.unread -->" itemprop="itemListElement">
				<meta itemprop="name" content="{topics.title}">
				<div class="category-item">
					<div class="category-body">
						<div class="row">
							<div class="col-md-8 col-sm-9">
								<div class="category-profile-pic">
									<a href="../../user/{topics.userslug}">
										<img src="{topics.picture}" alt="{topics.username}" class="profile-image user-img" title="{topics.username}">
									</a>
								</div>
								<div class="category-text">
									<p><strong><!-- IF topics.pinned --><i class="fa fa-thumb-tack"></i><!-- ENDIF topics.pinned --> <!-- IF topics.locked --><i class="fa fa-lock"></i><!-- ENDIF topics.locked --></strong>
										<a href="../../topic/{topics.slug}" itemprop="url" class="topic-title">{topics.title}</a><br />
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
								<a href="../../user/{topics.teaser.userslug}">
									<img class="profile-image small user-img" src="{topics.teaser.picture}" title="{teaser.username}"/>
								</a>
								<a href="../../topic/{topics.slug}#{topics.teaser.pid}">
									[[category:replied]]
									<span class="timeago" title="{topics.teaser.timestamp}"></span>
								</a>
								<!-- ENDIF topics.unreplied -->
							</div>
						</div>
					</div>
				</div>
			</li>
			<!-- END topics -->
		</ul>
		<!-- IF config.usePagination -->
		<div class="text-center">
			<ul class="pagination">
				<li class="previous pull-left"><a href="#"><i class="fa fa-chevron-left"></i> [[global:previouspage]]</a></li>
				<li class="next pull-right"><a href="#">[[global:nextpage]] <i class="fa fa-chevron-right"></i></a></li>
			</ul>
		</div>
		<!-- ENDIF config.usePagination -->
	</div>

	<!-- IF topics.length -->
	<div widget-area="sidebar" class="col-md-3 col-xs-12 category-sidebar">
		<!-- BEGIN widgets -->
		{widgets.html}
		<!-- END widgets -->
	</div>
	<!-- ENDIF topics.length -->
</div>

<input type="hidden" template-variable="category_id" value="{category_id}" />
<input type="hidden" template-variable="category_name" value="{category_name}" />
<input type="hidden" template-variable="currentPage" value="{currentPage}" />
<input type="hidden" template-variable="pageCount" value="{pageCount}" />