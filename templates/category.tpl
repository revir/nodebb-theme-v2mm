<input type="hidden" template-variable="category_id" value="{cid}" />
<input type="hidden" template-variable="category_name" value="{name}" />
<input type="hidden" template-variable="topic_count" value="{topic_count}" />
<input type="hidden" template-variable="currentPage" value="{currentPage}" />
<input type="hidden" template-variable="pageCount" value="{pageCount}" />

<ol class="breadcrumb">
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
		<a href="{relative_path}/" itemprop="url"><span itemprop="title">[[global:home]]</span></a>
	</li>
	<li class="active" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
		<span itemprop="title">{name} <a target="_blank" href="../{cid}.rss"><i class="fa fa-rss-square"></i></a></span>
	</li>
</ol>

<div class="category row">
	<div class="{topic_row_size}" no-widget-class="col-lg-12 col-sm-12" no-widget-target="sidebar">
		<div class="header" class="category-tools">
			<!-- IF privileges.write -->
			<button id="new_post" class="btn btn-primary">[[category:new_topic_button]]</button>
			<!-- ENDIF privileges.write -->

			<span class="dropdown share-dropdown pull-right">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					[[topic:share]] <span class="caret"></span>
				</button>

				<!-- IMPORT partials/share_dropdown.tpl -->
			</span>
		</div>

		<!-- IF !topics.length -->
		<div class="alert alert-warning" id="category-no-topics">
			[[category:no_topics]]
		</div>
		<!-- ENDIF !topics.length -->

		<ul id="topics-container" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}">
			<meta itemprop="itemListOrder" content="descending">
			<!-- BEGIN topics -->
			<li class="category-item <!-- IF topics.deleted --> deleted<!-- ENDIF topics.deleted --><!-- IF topics.unread --> unread<!-- ENDIF topics.unread -->" itemprop="itemListElement" data-tid="{topics.tid}" data-index="{topics.index}">
				<meta itemprop="name" content="{topics.title}">

				<div class="category-body">
					<div class="row">
						<div class="col-md-8 col-sm-9">
							<div class="category-profile-pic">
								<a href="../../user/{topics.user.userslug}">
									<!-- IF topics.thumb -->
									<img src="{topics.thumb}" alt="{topics.title}" class="profile-image user-img" title="{topics.title}">
									<!-- ELSE -->
									<img src="{topics.user.picture}" alt="{topics.user.username}" class="profile-image user-img" title="{topics.user.username}">
									<!-- ENDIF topics.thumb -->
								</a>
							</div>
							<div class="category-text">
								<p><strong><!-- IF topics.pinned --><i class="fa fa-thumb-tack"></i><!-- ENDIF topics.pinned --> <!-- IF topics.locked --><i class="fa fa-lock"></i><!-- ENDIF topics.locked --></strong>
									<a href="../../topic/{topics.slug}" itemprop="url" class="topic-title">{topics.title}</a><br />
									<small>[[category:posted]] <span class="timeago" title="{topics.relativeTime}"></span> by {topics.user.username}</small>
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
								<img class="profile-image small user-img" src="{topics.teaser.picture}" title="{topics.teaser.username}"/>
							</a>
							<a href="../../topic/{topics.slug}#{topics.teaser.pid}">
								[[category:replied]]
								<span class="timeago" title="{topics.teaser.timestamp}"></span>
							</a>
							<!-- ENDIF topics.unreplied -->
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

	<div widget-area="sidebar" class="col-md-3 col-xs-12 category-sidebar hidden"></div>
</div>

<!-- IMPORT partials/noscript/paginator.tpl -->