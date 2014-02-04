<input type="hidden" template-variable="expose_tools" value="{expose_tools}" />
<input type="hidden" template-variable="topic_id" value="{topic_id}" />
<input type="hidden" template-variable="currentPage" value="{currentPage}" />
<input type="hidden" template-variable="pageCount" value="{pageCount}" />
<input type="hidden" template-variable="locked" value="{locked}" />
<input type="hidden" template-variable="deleted" value="{deleted}" />
<input type="hidden" template-variable="pinned" value="{pinned}" />
<input type="hidden" template-variable="topic_name" value="{topic_name}" />
<input type="hidden" template-variable="postcount" value="{postcount}" />


<div class="topic">
	<ol class="breadcrumb">
		<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="{relative_path}/" itemprop="url"><span itemprop="title">[[global:home]]</span></a>
		</li>
		<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<a href="{relative_path}/category/{category_slug}" itemprop="url"><span itemprop="title">{category_name}</span></a>
		</li>
		<li class="active" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
			<span itemprop="title">{topic_name} <a target="_blank" href="../{topic_id}.rss"><i class="fa fa-rss-square"></i></a></span>
		</li>

	</ol>

	<ul id="post-container" class="posts" data-tid="{topic_id}">
		<!-- BEGIN posts -->
			<li class="post-row infiniteloaded" data-pid="{posts.pid}" data-uid="{posts.uid}" data-username="{posts.username}" data-userslug="{posts.userslug}" data-index="{posts.index}" data-deleted="{posts.deleted}" itemscope itemtype="http://schema.org/Comment">

				<a id="post_anchor_{posts.pid}" name="{posts.pid}"></a>

				<meta itemprop="datePublished" content="{posts.relativeTime}">
				<meta itemprop="dateModified" content="{posts.relativeEditTime}">

				<div class="topic-item">
					<div class="topic-body">
						<div class="row">
							<div class="col-md-12">
								<div class="topic-profile-pic">
									<a href="{relative_path}/user/{posts.userslug}">
										<img src="{posts.picture}" alt="{topics.teaser_username}" class="profile-image user-img" title="{posts.username}">
									</a>
								</div>
								<div class="topic-text">
									<!-- IF @first -->
									<h3 class="topic-title">
										<p id="topic_title_{posts.pid}" class="topic-title" itemprop="name">{topic_name}</p>
									</h3>
									<!-- ENDIF @first -->
									<div id="content_{posts.pid}" class="post-content" itemprop="text">{posts.content}</div>
									<!-- IF posts.signature -->
									<div class="post-signature">{posts.signature}</div>
									<!-- ENDIF posts.signature -->
								</div>
							</div>
						</div>
					</div>
					<div class="topic-footer">
						<div class="row">
							<div class="pull-left">
								<div class="dropdown">
									<a href="#" class="dropdown-toggle postMenu favourite-tooltip" id="postMenu_{posts.pid}" data-toggle="dropdown">
										<i class="fa fa-heart"></i>
									</a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="postMenu_{posts.pid}">
										<!-- IF @first -->
										<li role="presentation">
											<a role="menuitem" tabindex="-1" class="follow" title="Be notified of new replies in this topic">Watch <i class="fa fa-eye"></i></a>
										</li>
										<!-- ENDIF @first -->
										<li role="presentation">
											<a role="menuitem" tabindex="-1" data-favourited="{posts.favourited}" class="favourite">
												<span class="favourite-text">[[topic:favourite]]</span>
												<!-- IF posts.favourited -->
												<i class="fa fa-heart"></i>
												<!-- ELSE -->
												<i class="fa fa-heart-o"></i>
												<!-- ENDIF posts.favourited -->
											</a>
										</li>
										<!-- IF !disableSocialButtons -->
										<li role="presentation" class="divider"></li>
										<li role="presentation" class="dropdown-header">Share this Post</li>
										<li role="presentation">
											<a role="menuitem" class="facebook-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-facebook"></i></span> Facebook</a>
										</li>
										<li role="presentation">
											<a role="menuitem" class="twitter-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-twitter"></i></span> Twitter</a>
										</li>
										<li role="presentation">
											<a role="menuitem" class="google-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-google-plus"></i></span> Google+</a>
										</li>
										<!-- ENDIF !disableSocialButtons -->
									</ul>
								</div>
								<span class="post_rep_{posts.pid}">{posts.reputation} </span>
								<!-- BEGIN custom_profile_info -->
								&bull; {posts.custom_profile_info.content}
								<!-- END custom_profile_info -->
							</div>
							<div class="pull-right">
								<div class="btn-group post-tools">
									<button class="btn btn-sm btn-link chat" type="button" title="[[topic:chat]]"><i class="fa fa-comment"></i> [[topic:chat]]</button>
									<button class="btn btn-sm btn-link quote" type="button" title="[[topic:quote]]"><i class="fa fa-quote-left"></i> [[topic:quote]]</button>
									<button class="btn btn-sm btn-link post_reply" type="button"><i class="fa fa-reply"></i> [[topic:reply]]</button>
									<button class="btn btn-sm btn-link flag" type="button" title="[[topic:flag_title]]"><i class="fa fa-flag-o"></i> [[topic:flag]]</button>
									<!-- IF posts.display_moderator_tools -->
										<button class="btn btn-sm btn-link edit" type="button" title="[[topic:edit]]"><i class="fa fa-pencil"></i> [[topic:edit]]</button>
										<button class="btn btn-sm btn-link delete" type="button" title="[[topic:delete]]"><i class="fa fa-trash-o"></i> [[topic:delete]]</button>
										<!-- IF posts.display_move_tools -->
											<button class="btn btn-sm btn-link move" type="button" title="[[topic:move]]"><i class="fa fa-arrows"></i> [[topic:move]]</button>
										<!-- ENDIF posts.display_move_tools -->
									<!-- ENDIF posts.display_moderator_tools -->
								</div>
								<span>
									<i class="fa fa-circle status-offline"></i>
									<span class="username-field"></span>
								</span>
								<a href="{relative_path}/user/{posts.userslug}" itemprop="author">{posts.username}</a>
								[[category:posted]] <span class="relativeTimeAgo timeago" title="{posts.relativeTime}"></span>
								<!-- IF posts.editor -->
								<span>, [[category:last_edited_by]] <strong><a href="{relative_path}/user/{posts.editorslug}">{posts.editorname}</a></strong></span>
								<span class="timeago" title="{posts.relativeEditTime}"></span>
								<!-- ENDIF posts.editor -->
							</div>
						</div>
					</div>
				</div>
			</li>

			<!-- IF @first -->
			<li class="post-bar" data-index="{posts.index}">
				<div class="inline-block">
					<small class="topic-stats">
						<span>[[category:posts]]</span>
						<strong><span id="topic-post-count" class="human-readable-number" title="{postcount}">{postcount}</span></strong> |
						<span>[[category:views]]</span>
						<strong><span class="human-readable-number" title="{viewcount}">{viewcount}</span></strong> |
						<span>[[category:browsing]]</span>
					</small>
					<div class="thread_active_users active-users inline-block"></div>
				</div>
				<div class="topic-main-buttons pull-right inline-block">
					<button class="btn btn-primary post_reply" type="button">[[topic:reply]]</button>
					<div class="btn-group thread-tools hide">
						<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:thread_tools.title]] <span class="caret"></span></button>
						<ul class="dropdown-menu pull-right">
							<li><a href="#" class="markAsUnreadForAll"><i class="fa fa-inbox"></i> [[topic:thread_tools.markAsUnreadForAll]]</a></li>
							<li><a href="#" class="pin_thread"><i class="fa fa-thumb-tack"></i> [[topic:thread_tools.pin]]</a></li>
							<li><a href="#" class="lock_thread"><i class="fa fa-lock"></i> [[topic:thread_tools.lock]]</a></li>
							<li class="divider"></li>
							<li><a href="#" class="move_thread"><i class="fa fa-arrows"></i> [[topic:thread_tools.move]]</a></li>
							<li><a href="#" class="fork_thread"><i class="fa fa-code-fork"></i> [[topic:thread_tools.fork]]</a></li>
							<li class="divider"></li>
							<li><a href="#" class="delete_thread"><span class="text-error"><i class="fa fa-trash-o"></i> [[topic:thread_tools.delete]]</span></a></li>
						</ul>
					</div>
				</div>
				<div style="clear:both;"></div>
			</li>
			<!-- ENDIF @first -->
		<!-- END posts -->
	</ul>

	<div class="post-bar col-xs-12 pull-right hide bottom-post-bar">
		<div class="topic-main-buttons pull-right inline-block">
			<div class="loading-indicator" done="0" style="display:none;">
				<span class="hidden-xs-inline">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
			</div>
			<button class="btn btn-primary post_reply" type="button">[[topic:reply]]</button>
			<div class="btn-group thread-tools hide dropup">
				<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:thread_tools.title]] <span class="caret"></span></button>
				<ul class="dropdown-menu pull-right">
					<li><a href="#" class="markAsUnreadForAll"><i class="fa fa-inbox"></i> [[topic:thread_tools.markAsUnreadForAll]]</a></li>
					<li><a href="#" class="pin_thread"><i class="fa fa-thumb-tack"></i> [[topic:thread_tools.pin]]</a></li>
					<li><a href="#" class="lock_thread"><i class="fa fa-lock"></i> [[topic:thread_tools.lock]]</a></li>
					<li class="divider"></li>
					<li><a href="#" class="move_thread"><i class="fa fa-arrows"></i> [[topic:thread_tools.move]]</a></li>
					<li><a href="#" class="fork_thread"><i class="fa fa-code-fork"></i> [[topic:thread_tools.fork]]</a></li>
					<li class="divider"></li>
					<li><a href="#" class="delete_thread"><span class="text-error"><i class="fa fa-trash-o"></i> [[topic:thread_tools.delete]]</span></a></li>
				</ul>
			</div>
		</div>
		<div style="clear:both;"></div>
	</div>

	<!-- IF usePagination -->
	<div class="text-center">
		<ul class="pagination">
			<li class="previous pull-left"><a href="#"><i class="fa fa-chevron-left"></i> [[global:previouspage]]</a></li>
			<li class="next pull-right"><a href="#">[[global:nextpage]] <i class="fa fa-chevron-right"></i></a></li>
		</ul>
	</div>
	<!-- ENDIF usePagination -->

	<div id="move_thread_modal" class="modal" tabindex="-1" role="dialog" aria-labelledby="Move Topic" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h3>[[topic:move_topic]]</h3>
				</div>
				<div class="modal-body">
					<p id="categories-loading"><i class="fa fa-spin fa-refresh"></i> [[topic:load_categories]]</p>
					<ul class="category-list"></ul>
					<p>
						[[topic:disabled_categories_note]]
					</p>
					<div id="move-confirm" style="display: none;">
						<hr />
						<div class="alert alert-info">[[topic:topic_will_be_moved_to]] <strong><span id="confirm-category-name"></span></strong></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="move_thread_cancel">[[global:buttons.close]]</button>
					<button type="button" class="btn btn-primary" id="move_thread_commit" disabled>[[topic:confirm_move]]</button>
				</div>
			</div>
		</div>
	</div>


	<div id="fork-thread-modal" class="hide" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" data-backdrop="none">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4>[[topic:fork_topic]]</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="title">Title</label>
						<input id="fork-title" type="text" class="form-control" placeholder="Enter new thread title"><br/>
						<label>[[topic:fork_topic_instruction]]</label> <br/>
						<span id="fork-pids"></span>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="fork_thread_cancel">[[global:buttons.close]]</button>
					<button type="button" class="btn btn-primary" id="fork_thread_commit" disabled>[[topic:confirm_fork]]</button>
				</div>
			</div>
		</div>
	</div>

	<div id="move-post-modal" class="hide" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" data-backdrop="none">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4>[[topic:move_post]]</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="topicId">Topic ID</label>
						<input id="topicId" type="text" class="form-control" placeholder="Enter topic ID"><br/>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="move_post_cancel">[[global:buttons.close]]</button>
					<button type="button" class="btn btn-primary" id="move_post_commit" disabled>[[topic:confirm_move]]</button>
				</div>
			</div>
		</div>
	</div>

</div>