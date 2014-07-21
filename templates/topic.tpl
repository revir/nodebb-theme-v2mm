<input type="hidden" template-variable="topic_id" value="{tid}" />
<input type="hidden" template-variable="topic_slug" value="{slug}" />
<input type="hidden" template-variable="category_id" value="{category.cid}" />
<input type="hidden" template-variable="currentPage" value="{currentPage}" />
<input type="hidden" template-variable="pageCount" value="{pageCount}" />
<input type="hidden" template-variable="locked" template-type="boolean" value="{locked}" />
<input type="hidden" template-variable="deleted" template-type="boolean" value="{deleted}" />
<input type="hidden" template-variable="pinned" template-type="boolean" value="{pinned}" />
<input type="hidden" template-variable="topic_name" value="{title}" />
<input type="hidden" template-variable="postcount" value="{postcount}" />
<input type="hidden" template-variable="viewcount" value="{viewcount}" />


<div class="topic">
	<ol class="breadcrumb">
		<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="{relative_path}/" itemprop="url"><span itemprop="title">[[global:home]]</span></a>
		</li>
		<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="{relative_path}/category/{category.slug}" itemprop="url"><span itemprop="title">{category.name}</span></a>
		</li>
		<li class="active" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<span itemprop="title">{title} <a target="_blank" href="{relative_path}/topic/{tid}.rss"><i class="fa fa-rss-square"></i></a></span>
		</li>
		<div class="loading-indicator pull-right" done="0" style="display:none;">
			<i class="fa fa-refresh fa-spin"></i>
		</div>
	</ol>

	<ul id="post-container" class="posts" data-tid="{tid}">
		<!-- BEGIN posts -->
			<li class="post-row<!-- IF posts.deleted --> deleted<!-- ENDIF posts.deleted -->" data-pid="{posts.pid}" data-uid="{posts.uid}" data-username="{posts.user.username}" data-userslug="{posts.user.userslug}" data-index="{posts.index}" data-timestamp="{posts.timestamp}" data-votes="{posts.votes}" itemscope itemtype="http://schema.org/Comment">
				<a id="post_anchor_{posts.index}" name="{posts.index}"></a>

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

									<!-- IF posts.user.groups.length -->
									<div class="text-center">
									<!-- BEGIN groups -->
									<span class="label group-label inline-block" style="background-color: {posts.user.groups.labelColor};"><!-- IF posts.user.groups.icon --><i class="fa {posts.user.groups.icon}"></i> <!-- ENDIF posts.user.groups.icon -->{posts.user.groups.userTitle}</span><br/>
									<!-- END groups -->
									</div>
									<!-- ENDIF posts.user.groups.length -->
								</div>
								<div class="topic-text">
									<!-- IF @first -->
									<h3 class="topic-title">
										<p id="topic_title_{posts.pid}" class="topic-title" itemprop="name"><i class="fa fa-thumb-tack hide"></i> <i class="fa fa-lock hide"></i> {title}</p>
										<hr>
									</h3>
									<!-- ENDIF @first -->
									<div id="content_{posts.pid}" class="post-content" itemprop="text">{posts.content}</div>
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
										<i class="fa fa-circle status offline"></i>
										<!-- ENDIF posts.user.userslug -->
										<span class="username-field" data-username="{posts.user.username}">
											<!-- IF posts.user.userslug -->
											[[global:user_posted_ago, <a href="{relative_path}/user/{posts.user.userslug}" itemprop="author">{posts.user.username}</a>, <span class="timeago" title="{posts.relativeTime}"></span>]]
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
											<a href="#" role="menuitem" tabindex="-1" class="follow hide" title="[[topic:watch.title]]">[[topic:watch]] <i class="fa fa-eye"></i></a>
										</li>
										<li role="presentation">
											<a role="menuitem" tabindex="-1" data-favourited="{posts.favourited}" class="favourite">
												<span class="favourite-text">[[topic:favourite]]</span>
												<span class="favouriteCount" data-favourites="{posts.reputation}">{posts.reputation}</span>&nbsp;
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
								<a href="#" class="upvote <!-- IF posts.upvoted --> upvoted btn-primary <!-- ENDIF posts.upvoted -->">
									<i class="fa fa-chevron-up"></i>
								</a>
								<span class="votes" data-votes="{posts.votes}">{posts.votes}</span>
								<a href="#" class="downvote <!-- IF posts.downvoted --> downvoted btn-primary <!-- ENDIF posts.downvoted -->">
									<i class="fa fa-chevron-down"></i>
								</a>
								<!-- ENDIF !reputation:disabled -->

								<!-- IF posts.user.custom_profile_info.length -->
									<!-- BEGIN custom_profile_info -->
									&bull; {posts.user.custom_profile_info.content}
									<!-- END custom_profile_info -->
								<!-- ENDIF posts.user.custom_profile_info.length -->
								<span class="post-tools">
									<!-- IF !posts.selfPost -->
									<!-- IF posts.user.userslug -->
									<button class="btn btn-sm btn-link chat" type="button" title="[[topic:chat]]"><i class="fa fa-comment"></i><span class="hidden-xs-inline"> [[topic:chat]]</span></button>
									<!-- ENDIF posts.user.userslug -->
									<!-- ENDIF !posts.selfPost -->
									<!-- IF privileges.topics:reply -->
									<button class="btn btn-sm btn-link quote" type="button" title="[[topic:quote]]"><i class="fa fa-quote-left"></i><span class="hidden-xs-inline"> [[topic:quote]]</span></button>
									<button class="btn btn-sm btn-link post_reply" type="button"><i class="fa fa-reply"></i><span class="hidden-xs-inline"> [[topic:reply]]</span></button>
									<!-- ENDIF privileges.topics:reply -->
									<!-- IF !posts.selfPost -->
									<button class="btn btn-sm btn-link flag" type="button" title="[[topic:flag_title]]"><i class="fa fa-flag-o"></i><span class="hidden-xs-inline"> [[topic:flag]]</span></button>
									<!-- ENDIF !posts.selfPost -->
									<!-- IF posts.display_moderator_tools -->
										<button class="btn btn-sm btn-link edit" type="button" title="[[topic:edit]]"><i class="fa fa-pencil"></i><span class="hidden-xs-inline"> [[topic:edit]]</span></button>
										<button class="btn btn-sm btn-link delete" type="button" title="[[topic:delete]]"><i class="fa fa-trash-o"></i><span class="hidden-xs-inline"> [[topic:delete]]</span></button>
										<button class="btn btn-sm btn-link purge <!-- IF !posts.deleted -->none<!-- ENDIF !posts.deleted -->" type="button" title="[[topic:purge]]"><i class="fa fa-eraser"></i><span class="hidden-xs-inline"> [[topic:purge]]</span></button>
										<!-- IF posts.display_move_tools -->
											<button class="btn btn-sm btn-link move" type="button" title="[[topic:move]]"><i class="fa fa-arrows"></i><span class="hidden-xs-inline"> [[topic:move]]</span></button>
										<!-- ENDIF posts.display_move_tools -->
									<!-- ENDIF posts.display_moderator_tools -->
								</span>
							</div>
						</div>
					</div>
				</div>
			</li>

			<!-- IF !posts.index -->
			<li class="post-bar" data-index="{posts.index}">
				<!-- IMPORT partials/post_bar.tpl -->
			</li>
			<!-- ENDIF !posts.index -->
		<!-- END posts -->
	</ul>

	<div class="post-bar col-xs-12 hide bottom-post-bar">
		<!-- IMPORT partials/post_bar.tpl -->
	</div>

	<!-- IF config.usePagination -->
	<div class="text-center">
		<ul class="pagination">
			<li class="previous pull-left"><a href="#"><i class="fa fa-chevron-left"></i> [[global:previouspage]]</a></li>
			<li class="next pull-right"><a href="#">[[global:nextpage]] <i class="fa fa-chevron-right"></i></a></li>
		</ul>
	</div>
	<!-- ENDIF config.usePagination -->

	<!-- IMPORT partials/move_thread_modal.tpl -->
	<!-- IMPORT partials/fork_thread_modal.tpl -->
	<!-- IMPORT partials/move_post_modal.tpl -->
</div>

<!-- IMPORT partials/noscript/paginator.tpl -->
