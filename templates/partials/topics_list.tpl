		<ul component="category" id="topics-container" data-nextstart="{nextStart}">
			<meta itemprop="itemListOrder" content="descending">
			<!-- BEGIN topics -->
			<li component="category/topic" class="category-item {function.generateTopicClass}" itemprop="itemListElement" <!-- IMPORT partials/data/category.tpl -->>
				<meta itemprop="name" content="{function.stripTags, title}">

				<div class="category-body">
					<div class="row">
						<div class="<!-- IF !isCustom --> col-md-8 col-sm-10 <!-- ENDIF !isCustom --> col-xs-12">

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

								<i class="fa fa-bar-chart-o<!-- IF !topics.pollId --> hide<!-- ENDIF !topics.pollId -->"></i>

								</strong>

								<!-- BEGIN topics.labels -->
								<span
								class="label topic-label"
								style="background-color: {topics.labels.bkColor}; color: {topics.labels.color}"
								data-name={topics.labels.name}>

								{topics.labels.value}
								</span>
								<!-- END topics.labels -->

								<!-- IF topics.noAnchor -->
								<a component="topic/header" itemprop="url" class="topic-title">{topics.title}</a>
								<br />

								<!-- ELSE -->
									<!-- IF topics.externalLink -->
										<a component="topic/header" href="{topics.externalLink}" rel="nofollow" target="_blank" itemprop="url" class="topic-title external-link" data-tid="{topics.tid}">
											<i class="fa fa-external-link"></i>
											{topics.title}
										</a>
										&nbsp;
										<a component="topic/header" href="{config.relative_path}/topic/{topics.slug}" itemprop="url" class="topic-title">
											<i class="fa fa-arrow-right" aria-hidden="true"></i>
										</a>
										<br />

									<!-- ELSE -->
										<a component="topic/header" href="{config.relative_path}/topic/{topics.slug}" itemprop="url" class="topic-title">{topics.title}</a>
										<br />
									<!-- ENDIF topics.externalLink -->
								<!-- ENDIF topics.noAnchor -->

									<small>
									<a class="topic-category-name" href="{config.relative_path}/category/{topics.category.slug}">
									{topics.category.name}</a>

									&bull;
									<a href="{config.relative_path}/topic/{topics.slug}" itemprop="url">
										<span class="timeago small text-muted" title="{topics.timestampISO}"></span>
									</a>

									<span class="visible-xs-inline">
									&bull;
									<a class="text-muted" href="{config.relative_path}/topic/{topics.slug}" itemprop="url">
										<span>
											<i title="[[global:views]]" class="fa fa-eye"></i>
											<strong class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</strong>
										</span>
									</a>
									&bull;
									<a class="text-muted" href="{config.relative_path}/topic/{topics.slug}" itemprop="url">
										<span>
											<i title="[[global:posts]]" class="fa fa-comment-o"></i>
											<strong class="human-readable-number" title="{topics.postcount}">{topics.postcount}</strong>
										</span>
									</a>
									<!-- IF !topics.unreplied -->
									&bull;
									<a href="{config.relative_path}/topic/{topics.slug}/{topics.teaser.index}"><span class="timeago text-muted" title="{topics.teaser.timestampISO}"></span></a>
									<!-- ENDIF !topics.unreplied -->
									</span>
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


						<div class="col-xs-2 replies hidden-sm hidden-xs">
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
										<span class="timeago text-muted" title="{topics.teaser.timestampISO}"></span>
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

			<!-- IF @last -->
			<li class="v2mm-loading-spin text-center hidden hidden-sm hidden-xs">
			    <i class="fa fa-spinner fa-spin fa-4x" title="loading..."></i>
			</li>
			<!-- ENDIF @last -->

			<!-- END topics -->
		</ul>
