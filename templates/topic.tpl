<div class="topic">
	<!-- IMPORT partials/breadcrumbs.tpl -->

	<ul component="topic" id="post-container" class="posts" data-tid="{tid}">
		<!-- BEGIN posts -->
			<li component="post" class="post-row <!-- IF posts.deleted -->deleted<!-- ENDIF posts.deleted -->" <!-- IMPORT partials/data/topic.tpl -->>
				<a component="post/anchor" name="{posts.index}"></a>

				<meta itemprop="datePublished" content="{posts.relativeTime}">
				<meta itemprop="dateModified" content="{posts.relativeEditTime}">

				<div class="topic-item">
					<div class="topic-body">
						<div class="row">
							<div class="col-md-12">
								<div class="topic-profile-pic hidden-xs text-center">
									<a href="<!-- IF posts.user.userslug -->{relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
										<img src="{posts.user.picture}" alt="{posts.user.username}" class="profile-image user-img" title="{posts.user.username}">
									</a>
									<small class="username" title="{posts.user.username}"><a href="<!-- IF posts.user.userslug -->{relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">{posts.user.username}</a></small>

									<!-- IF posts.user.banned -->
									<div class="text-center">
										<span class="label label-danger">[[user:banned]]</span>
									</div>
									<!-- ENDIF posts.user.banned -->

									<!-- IF posts.user.groups.length -->
									<div class="text-center">
									<!-- BEGIN groups -->
									<!-- IF groups.selected -->
									<!-- IF groups.userTitleEnabled -->
									<a href="{relative_path}/groups/{posts.user.groups.slug}"><span class="label group-label inline-block" style="background-color: {posts.user.groups.labelColor};"><!-- IF posts.user.groups.icon --><i class="fa {posts.user.groups.icon}"></i> <!-- ENDIF posts.user.groups.icon -->{posts.user.groups.userTitle}</span></a><br/>
									<!-- ENDIF groups.userTitleEnabled -->
									<!-- ENDIF groups.selected -->
									<!-- END groups -->
									</div>
									<!-- ENDIF posts.user.groups.length -->
								</div>
								<div class="topic-text">
									<!-- IF @first -->
									<h3 class="topic-title">
										<p component="post/header" class="topic-title" itemprop="name"><i class="fa fa-thumb-tack hide"></i> <i class="fa fa-lock hide"></i> {title}</p>
										<hr>
									</h3>
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
								<small class="pull-right">
									<span>
										<!-- IF posts.user.userslug -->
										<i class="fa fa-circle status {posts.user.status}" title='[[global:{posts.user.status}]]'></i>
										<!-- ENDIF posts.user.userslug -->
										<span class="username-field" data-username="{posts.user.username}" data-uid="{posts.user.uid}">
											<!-- IF posts.user.userslug -->
											[[global:user_posted_ago, <strong><a href="{relative_path}/user/{posts.user.userslug}" itemprop="author">{posts.user.username}</a></strong>, <span class="timeago" title="{posts.relativeTime}"></span>]]
											<!-- ELSE -->
											[[global:guest_posted_ago, <span class="timeago" title="{posts.relativeTime}"></span>]]
											<!-- ENDIF posts.user.userslug -->
										</span>
									</span>

									<!-- IF posts.editor.username -->
									<span>, [[global:last_edited_by_ago, <strong><a href="{relative_path}/user/{posts.editor.userslug}">{posts.editor.username}</a></strong>, <span class="timeago" title="{posts.relativeEditTime}"></span>]]</span>
									<!-- ENDIF posts.editor.username -->
								</small>

								<div class="dropdown share-dropdown">
									<a href="#" class="dropdown-toggle postMenu favourite-tooltip" id="postMenu_{posts.pid}" data-toggle="dropdown">
										<i class="fa fa-heart"></i>
									</a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="postMenu_{posts.pid}">
										<li role="presentation">
											<!-- IF !posts.index -->
											<!-- IF isFollowing -->
											<a component="topic/follow" href="#" role="menuitem" tabindex="-1" class="follow" title="[[topic:unwatch.title]]"><span>[[topic:unwatch]]</span> <i class="fa fa-eye-slash"></i></a>
											<!-- ELSE -->
											<a component="topic/follow" href="#" role="menuitem" tabindex="-1" class="follow" title="[[topic:watch.title]]"><span>[[topic:watch]]</span> <i class="fa fa-eye"></i></a>
											<!-- ENDIF isFollowing -->
											<!-- ENDIF !posts.index -->
										</li>
										<li role="presentation">
											<a component="post/favourite" role="menuitem" tabindex="-1" data-favourited="{posts.favourited}" class="favourite">
												<span class="favourite-text">[[topic:favourite]]</span>
												<span component="post/favourite-count" class="favouriteCount" data-favourites="{posts.reputation}">{posts.reputation}</span>&nbsp;
												<!-- IF posts.favourited -->
												<i class="fa fa-heart"></i>
												<!-- ELSE -->
												<i class="fa fa-heart-o"></i>
												<!-- ENDIF posts.favourited -->
											</a>
										</li>
										<!-- IF !config.disableSocialButtons -->
										<li role="presentation" class="divider"></li>
										<li role="presentation" class="dropdown-header">[[topic:share_this_post]]</li>
										<li role="presentation">
											<a role="menuitem" class="facebook-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-facebook"></i></span> Facebook</a>
										</li>
										<li role="presentation">
											<a role="menuitem" class="twitter-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-twitter"></i></span> Twitter</a>
										</li>
										<li role="presentation">
											<a role="menuitem" class="google-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-google-plus"></i></span> Google+</a>
										</li>
										<!-- ENDIF !config.disableSocialButtons -->
										<li class="text-center">
											<input type="text" id="post_{posts.pid}_link" value="" class="form-control post-link inline-block"></input>
										</li>
									</ul>
								</div>
								<!-- IF !reputation:disabled -->
								&bull;
								<a component="post/upvote" href="#" class="upvote<!-- IF posts.upvoted --> upvoted<!-- ENDIF posts.upvoted -->">
									<i class="fa fa-chevron-up"></i>
								</a>
								<span component="post/vote-count" class="votes" data-votes="{posts.votes}">{posts.votes}</span>
								<!-- IF !downvote:disabled -->
								<a component="post/downvote" href="#" class="downvote<!-- IF posts.downvoted --> downvoted<!-- ENDIF posts.downvoted -->">
									<i class="fa fa-chevron-down"></i>
								</a>
								<!-- ENDIF !downvote:disabled -->
								<!-- ENDIF !reputation:disabled -->

								<!-- IF posts.user.custom_profile_info.length -->
									<!-- BEGIN custom_profile_info -->
									&bull; {posts.user.custom_profile_info.content}
									<!-- END custom_profile_info -->
								<!-- ENDIF posts.user.custom_profile_info.length -->
								<span class="post-tools">
									<!-- IF !posts.selfPost -->
									<!-- IF posts.user.userslug -->
									<!-- IF loggedIn -->
									<!-- IF !config.disableChat -->
									<button component="post/chat" class="btn btn-sm btn-link chat" type="button" title="[[topic:chat]]"><i class="fa fa-comment"></i><span class="hidden-xs-inline"> [[topic:chat]]</span></button>
									<!-- ENDIF !config.disableChat -->
									<!-- ENDIF loggedIn -->
									<!-- ENDIF posts.user.userslug -->
									<!-- ENDIF !posts.selfPost -->
									<!-- IF privileges.topics:reply -->
									<button component="post/quote" class="btn btn-sm btn-link quote" type="button" title="[[topic:quote]]"><i class="fa fa-quote-left"></i><span class="hidden-xs-inline"> [[topic:quote]]</span></button>
									<button component="post/reply" class="btn btn-sm btn-link post_reply" type="button"><i class="fa fa-reply"></i><span class="hidden-xs-inline"> [[topic:reply]]</span></button>
									<!-- ENDIF privileges.topics:reply -->
									<!-- IF !posts.selfPost -->
									<!-- IF loggedIn -->
									<button component="post/flag" class="btn btn-sm btn-link flag" type="button" title="[[topic:flag_title]]"><i class="fa fa-flag-o"></i><span class="hidden-xs-inline"> [[topic:flag]]</span></button>
									<!-- ENDIF loggedIn -->
									<!-- ENDIF !posts.selfPost -->
									<!-- IF posts.display_moderator_tools -->
										<button component="post/edit" class="btn btn-sm btn-link edit" type="button" title="[[topic:edit]]"><i class="fa fa-pencil"></i><span class="hidden-xs-inline"> [[topic:edit]]</span></button>
										<button component="post/delete" class="btn btn-sm btn-link delete" type="button" title="[[topic:delete]]"><i class="fa fa-trash-o"></i><span class="hidden-xs-inline"> [[topic:delete]]</span></button>
										<button component="post/purge" class="btn btn-sm btn-link purge <!-- IF !posts.deleted -->hidden<!-- ENDIF !posts.deleted -->" type="button" title="[[topic:purge]]"><i class="fa fa-eraser"></i><span class="hidden-xs-inline"> [[topic:purge]]</span></button>
										<!-- IF posts.display_move_tools -->
											<button component="post/move" class="btn btn-sm btn-link move" type="button" title="[[topic:move]]"><i class="fa fa-arrows"></i><span class="hidden-xs-inline"> [[topic:move]]</span></button>
										<!-- ENDIF posts.display_move_tools -->
									<!-- ENDIF posts.display_moderator_tools -->
								</span>
							</div>
						</div>
					</div>
				</div>
			</li>

			<!-- IF !posts.index -->
			<div class="post-bar" data-index="{posts.index}">
				<!-- IMPORT partials/post_bar.tpl -->
			</div>
			<!-- ENDIF !posts.index -->
		<!-- END posts -->
	</ul>

	<div class="post-bar col-xs-12 <!-- IF unreplied -->hide<!-- ENDIF unreplied --> bottom-post-bar">
		<!-- IMPORT partials/post_bar.tpl -->
	</div>

	<!-- IF config.usePagination -->
		<!-- IMPORT partials/paginator.tpl -->
	<!-- ENDIF config.usePagination -->

	<!-- IMPORT partials/move_thread_modal.tpl -->
	<!-- IMPORT partials/fork_thread_modal.tpl -->
	<!-- IMPORT partials/move_post_modal.tpl -->
</div>

<!-- IMPORT partials/noscript/paginator.tpl -->
<!-- IMPORT partials/variables/topic.tpl -->