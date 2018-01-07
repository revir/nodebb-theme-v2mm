<div class="topic">
	<!-- IMPORT partials/breadcrumbs.tpl -->

	<div component="topic/deleted/message" class="alert alert-warning<!-- IF !deleted --> hidden<!-- ENDIF !deleted -->">[[topic:deleted_message]]</div>

	<ul component="topic" id="post-container" class="posts" data-tid="{tid}">
		<!-- BEGIN posts -->
			<li component="post" class="<!-- IF posts.deleted -->deleted<!-- ENDIF posts.deleted -->" <!-- IMPORT partials/data/topic.tpl -->>
				<a component="post/anchor" data-index="{posts.index}" name="{posts.index}"></a>
				<div class="post-row">

					<meta itemprop="datePublished" content="{posts.timestampISO}">
					<meta itemprop="dateModified" content="{posts.editedISO}">

					<div class="topic-item">
						<div class="topic-header visible-xs">
							<div class="row">
								<div class="col-xs-12">
									<small class="">
										<span>
											<!-- IF posts.user.userslug -->
											<i component="user/status" class="fa fa-circle status {posts.user.status}" title='[[global:{posts.user.status}]]'></i>
											<!-- ENDIF posts.user.userslug -->
											<span data-username="{posts.user.username}" data-uid="{posts.user.uid}">
												<!-- IF posts.user.uid -->
												<strong><a href="{config.relative_path}/user/{posts.user.userslug}" itemprop="author">{posts.user.username}</a></strong> | <span class="timeago small text-muted" title="{posts.timestampISO}"></span>
												<!-- ELSE -->
												[[global:guest]] | <span class="timeago" title="{posts.timestampISO}"></span>
												<!-- ENDIF posts.user.uid -->
											</span>
										</span>
										<span component="post/editor" class="hidden-xs hidden-sm text-muted <!-- IF !posts.editor.username --> hidden<!-- ENDIF !posts.editor.username -->">, [[global:last_edited_by, {posts.editor.username}]] <span class="timeago small text-muted" title="{posts.editedISO}"></span></span>

									</small>
								</div>
							</div>
						</div>
						<div class="topic-body">
							<div class="row">
								<div class="col-md-12">
									<div class="topic-profile-pic hidden-xs text-center">
										<a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
											<!-- IF posts.user.picture -->
											<img itemprop="image" component="user/picture" data-uid="{posts.user.uid}" src="{posts.user.picture}" align="left" class="img-thumbnail user-icon" />
											<!-- ELSE -->
											<div class="user-icon" style="background-color: {posts.user.icon:bgColor};">{posts.user.icon:text}</div>
											<!-- ENDIF posts.user.picture -->
										</a>
										<small class="username" title="{posts.user.username}"><a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">{posts.user.username}</a></small>

										<!-- IF posts.user.banned -->
										<div class="text-center">
											<span class="label label-danger">[[user:banned]]</span>
										</div>
										<!-- ENDIF posts.user.banned -->

										<!-- IMPORT partials/topic/badge.tpl -->
									</div>
									<div class="topic-text">
										<!-- IF @first -->
										<!-- IF privileges.isAdminOrMod -->
										<button component="post/edit" class="btn btn-default btn-sm pull-right" type="button">
											<span class="hidden-xs"> [[topic:edit]]</span>
										</button>
										<!-- END -->
										<h1 class="topic-title">
											<p component="post/header" class="topic-title" itemprop="name">
											<i class="fa fa-thumb-tack <!-- IF !pinned -->hidden<!-- ENDIF !pinned -->"></i>
											<i class="fa fa-lock <!-- IF !locked -->hidden<!-- ENDIF !locked -->"></i>

											<!-- BEGIN labels -->
											<span
											class="label topic-label"
											style="background-color: {labels.bkColor}; color: {labels.color}"
											data-name={labels.name}>

											{labels.value}
											</span>
											<!-- END labels -->

											<!-- IF externalLink -->
											<a href="{externalLink}" rel="nofollow" target="_blank" itemprop="url" class="topic-title external-link" data-tid="{tid}">
											<i class="fa fa-external-link"></i>
											<!-- ENDIF externalLink -->

											<span component="topic/title">{title}</span>

											<!-- IF externalLink -->
											</a>
											<!-- ENDIF externalLink -->

											</p>

											<hr/>
										</h1>
										<!-- ENDIF @first -->
										<div component="post/content" class="post-content" itemprop="text">{posts.content}</div>
										<!-- IF posts.user.signature -->
										<div class="post-signature">{posts.user.signature}</div>
										<!-- ENDIF posts.user.signature -->
									</div>
								</div>
							</div>
						</div>
						<div class="topic-footer">
							<div class="row">
								<div class="">
									<small class="pull-right hidden-xs">
										<span>
											<!-- IF posts.user.userslug -->
											<i component="user/status" class="fa fa-circle status {posts.user.status}" title='[[global:{posts.user.status}]]'></i>
											<!-- ENDIF posts.user.userslug -->
											<span data-username="{posts.user.username}" data-uid="{posts.user.uid}">
												<!-- IF posts.user.uid -->
												<strong><a href="{config.relative_path}/user/{posts.user.userslug}" itemprop="author">{posts.user.username}</a></strong> | <span class="timeago small text-muted" title="{posts.timestampISO}"></span>
												<!-- ELSE -->
												[[global:guest]] | <span class="timeago" title="{posts.timestampISO}"></span>
												<!-- ENDIF posts.user.uid -->
											</span>
										</span>

										<span component="post/editor" class="hidden-xs hidden-sm text-muted <!-- IF !posts.editor.username --> hidden<!-- ENDIF !posts.editor.username -->">, [[global:last_edited_by, {posts.editor.username}]] <span class="timeago small text-muted" title="{posts.editedISO}"></span></span>

									</small>

									<!-- IF !reputation:disabled -->
									<span class="votes-wrapper">
										<a component="post/upvote" href="#" class="toggle-tool upvote<!-- IF posts.upvoted --> upvoted <!-- ENDIF posts.upvoted -->">
											<i title="[[v2mm:upvote]]" class="fa fa-thumbs-o-up"></i>
										</a>
										<span component="post/vote-count" class="vote-count " data-votes="{posts.votes}">{posts.votes}</span>
										<!-- IF !downvote:disabled -->
										<a component="post/downvote" href="#" class="toggle-tool downvote<!-- IF posts.downvoted --> downvoted <!-- ENDIF posts.downvoted -->">
											<i title="[[v2mm:downvote]]" class="fa fa-thumbs-o-down"></i>
										</a>
										<!-- ENDIF !downvote:disabled -->
									</span>
									<!-- ENDIF !reputation:disabled -->

									<a class="toggle-tool" component="post/bookmark" href="#" data-bookmarked="{posts.bookmarked}" title="[[topic:bookmark]]">
										<i component="post/bookmark/on" class="fa fa-bookmark bookmarked <!-- IF !posts.bookmarked -->hidden<!-- ENDIF !posts.bookmarked -->"></i>
										<i component="post/bookmark/off" class="fa fa-bookmark-o <!-- IF posts.bookmarked -->hidden<!-- ENDIF posts.bookmarked -->"></i>
									</a>

									<div class="dropdown moderator-tools toggle-tool" component="post/tools">
										<a href="#" data-toggle="dropdown"><i class="fa fa-fw fa-plus-square-o"></i></a>
										<ul class="dropdown-menu" role="menu"></ul>
									</div>

									<!-- IF posts.user.custom_profile_info.length -->
										<!-- BEGIN custom_profile_info -->
										&bull; {posts.user.custom_profile_info.content}
										<!-- END custom_profile_info -->
									<!-- ENDIF posts.user.custom_profile_info.length -->
									<span class="post-tools">
										<a href="#" class='btn btn-link need-share-button'
										    data-share-url='{config.relative_path}/post/{posts.pid}'
										    data-share-image='{posts.user.picture}'
										    title="分享"
										>
											<i class="fa fa-share-alt" aria-hidden="true"></i>
											<span class="hidden-xs"> [[topic:share]]</span>
										</a>

										<button component="post/quote" class="btn btn-link <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->" type="button" title="[[topic:quote]]"><i class="fa fa-quote-left"></i>
											<span class="hidden-xs"> [[topic:quote]]</span>
										</button>
										<button component="post/reply" class="btn btn-link <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->" type="button"><i class="fa fa-reply"></i>
											<span class="hidden-xs"> [[topic:reply]]</span>
										</button>
									</span>
								</div>
							</div>



						</div>
					</div>
				</div>
				<!-- IF !posts.index -->
				<div class="post-bar hidden">
					<!-- IMPORT partials/post_bar.tpl -->
				</div>
				<!-- ENDIF !posts.index -->
			</li>
		<!-- END posts -->
	</ul>

	<div class="post-bar">
		<!-- IMPORT partials/post_bar.tpl -->
	</div>

	<!-- IF config.usePagination -->
		<!-- IMPORT partials/paginator.tpl -->
	<!-- ENDIF config.usePagination -->

	<div class="visible-xs visible-sm pagination-block text-center">
		<div class="progress-bar"></div>
		<div class="wrapper">
			<i class="fa fa-2x fa-angle-double-up pointer fa-fw pagetop"></i>
			<i class="fa fa-2x fa-angle-up pointer fa-fw pageup"></i>
			<span class="pagination-text"></span>
			<i class="fa fa-2x fa-angle-down pointer fa-fw pagedown"></i>
			<i class="fa fa-2x fa-angle-double-down pointer fa-fw pagebottom"></i>
		</div>
	</div>


</div>

<!-- IF !config.usePagination -->
<noscript>
	<!-- IMPORT partials/paginator.tpl -->
</noscript>
<!-- ENDIF !config.usePagination -->
