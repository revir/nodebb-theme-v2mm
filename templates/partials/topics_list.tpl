		<ul component="category" id="topics-container" data-nextstart="{nextStart}">
			<meta itemprop="itemListOrder" content="descending">
			<!-- BEGIN topics -->
			<li component="category/topic" class="category-item {function.generateTopicClass}" itemprop="itemListElement" <!-- IMPORT partials/data/category.tpl -->>
				<meta itemprop="name" content="{function.stripTags, title}">

				<div class="category-body">
					<div class="row">

						<div class="col-md-8 col-sm-9">

							<!-- IF showSelect -->
							<i class="fa fa-fw fa-square-o pull-left select pointer" component="topic/select"></i>
							<!-- ENDIF showSelect -->

							<div class="category-profile-pic">
								<a href="<!-- IF topics.user.userslug -->{config.relative_path}/user/{topics.user.userslug}<!-- ELSE -->#<!-- ENDIF topics.user.userslug -->">
									<!-- IF topics.thumb -->
									<img src="{topics.thumb}" class="user-img" title="{topics.user.username}" />
									<!-- ELSE -->
									<!-- IF topics.user.picture -->
									<img component="user/picture" data-uid="{topics.user.uid}" src="{topics.user.picture}" class="user-img" title="{topics.user.username}" />
									<!-- ELSE -->
									<div class="user-icon" style="background-color: {topics.user.icon:bgColor};" title="{topics.user.username}">{topics.user.icon:text}</div>
									<!-- ENDIF topics.user.picture -->
									<!-- ENDIF topics.thumb -->
								</a>
							</div>
							<div class="category-text">
								<p>
								<strong>
								<i component="topic/pinned" class="fa fa-thumb-tack<!-- IF !topics.pinned --> hide<!-- ENDIF !topics.pinned -->"></i>
								<i component="topic/locked" class="fa fa-lock<!-- IF !topics.locked --> hide<!-- ENDIF !topics.locked -->"></i>

								</strong>
									<!-- IF topics.externalLink -->
									<a component="topic/header" href="{config.relative_path}/external_topic?tid={topics.tid}&link={topics.externalLink}" target="_blank" itemprop="url" class="topic-title external-link" onclick="$(this).closest('li.unread').removeClass('unread')">
										<i class="fa fa-external-link <!-- IF !topics.externalLink --> hide<!-- ENDIF !topics.externalLink -->"></i>
										{topics.title}
									</a>
									&nbsp;
									<a component="topic/header" href="{config.relative_path}/topic/{topics.slug}" itemprop="url" class="topic-title">
										<i class="fa fa-arrow-right" aria-hidden="true"></i>
									</a>

									<br />
									<!-- ELSE -->

										<!-- IF !topics.noAnchor -->
										<a component="topic/header" href="{config.relative_path}/topic/{topics.slug}" itemprop="url" class="topic-title">{topics.title}</a><br />
										<!-- ELSE -->
										<a component="topic/header" itemprop="url" class="topic-title">{topics.title}</a><br />
										<!-- ENDIF !topics.noAnchor -->

									<!-- ENDIF topics.externalLink -->

									<small>
									<a href="{config.relative_path}/category/{topics.category.slug}"><i class="fa {topics.category.icon}"></i> {topics.category.name}</a> &bull; <span class="timeago small text-muted" title="{topics.timestampISO}"></span>
									<!-- IF !topics.unreplied -->
									<span class="hidden-md hidden-lg">
									<br/>
									<a href="{config.relative_path}/topic/{topics.slug}/{topics.teaser.index}"><span class="timeago" title="{topics.teaser.timestampISO}"></span></a>
									</span>
									<!-- ENDIF !topics.unreplied -->
									<br/>
									<!-- IMPORT partials/category_tags.tpl -->
									</small>
								</p>
							</div>
						</div>

						<div class="col-xs-1 category-stat hidden-xs">
							<strong class="human-readable-number" title="{topics.postcount}">{topics.postcount}</strong><br />
							<small>[[global:posts]]</small>
						</div>

						<div class="col-xs-1 category-stat hidden-xs">
							<strong class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</strong><br />
							<small>[[global:views]]</small>
						</div>

						<div class="col-xs-2 category-stat replies hidden-sm hidden-xs">
							<div class="card" style="border-color: {topics.category.bgColor}">
								<!-- IF topics.unreplied -->
								<p>
									[[category:no_replies]]
								</p>

								<!-- ELSE -->
								<!-- IF topics.teaser.pid -->
								<p>
									<a href="{config.relative_path}/user/{topics.teaser.user.userslug}">
										<!-- IF topics.teaser.user.picture -->
										<img title="{topics.teaser.user.username}" class="user-img" src="{topics.teaser.user.picture}" />
										<!-- ELSE -->
										<span title="{topics.teaser.user.username}" class="user-icon user-img" style="background-color: {topics.teaser.user.icon:bgColor};">{topics.teaser.user.icon:text}</span>
										<!-- ENDIF topics.teaser.user.picture -->
									</a>
									<a class="permalink" href="{config.relative_path}/topic/{topics.slug}/{topics.teaser.index}">
										<span class="timeago" title="{topics.teaser.timestampISO}"></span>
									</a>
								</p>
								<div class="post-content">
									{topics.teaser.content}
								</div>
								<!-- ENDIF topics.teaser.pid -->
								<!-- ENDIF topics.unreplied -->
							</div>


						</div>
					</div>
				</div>

			</li>
			<!-- END topics -->
		</ul>
