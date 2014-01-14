<ol class="breadcrumb">
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
		<a href="{relative_path}/" itemprop="url"><span itemprop="title">[[global:home]]</span></a>
	</li>
	<li class="active" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
		<span itemprop="title">{category_name} <a target="_blank" href="../{category_id}.rss"><i class="fa fa-rss-square"></i></a></span>
	</li>
</ol>

<div>
	<button id="new_post" class="btn btn-primary {show_topic_button}">[[category:new_topic_button]]</button>
	<!-- IF !disableSocialButtons -->
	<div class="inline-block pull-right">
		<a href="#" id="facebook-share"><i class="fa fa-facebook-square fa-2x"></i></a>&nbsp;
		<a href="#" id="twitter-intent"><i class="fa fa-twitter-square fa-2x"></i></a>&nbsp;
		<a href="#" id="google-share"><i class="fa fa-google-plus-square fa-2x"></i></a>&nbsp;
	</div>
	<!-- ENDIF !disableSocialButtons -->
</div>

<hr/>

<div class="alert alert-warning hide {no_topics_message}" id="category-no-topics">
	[[category:no_topics]]
</div>

<div class="category row">
	<div class="{topic_row_size}">
		<ul id="topics-container" itemscope itemtype="http://www.schema.org/ItemList">
			<meta itemprop="itemListOrder" content="descending">
			<!-- BEGIN topics -->
			<li class="category-list {topics.deleted-class}" itemprop="itemListElement">
				<meta itemprop="name" content="{topics.title}">
				<div class="category-item">
					<div class="category-body">
						<div class="row">
							<div class="col-md-8 col-sm-9">
								<div class="category-profile-pic">
									<img src="{topics.picture}" alt="{topics.teaser_username}" class="profile-image">
								</div>
								<div class="category-text">
									<p><strong><i class="fa {topics.pin-icon}"></i> <i class="fa {topics.lock-icon}"></i></strong>
										<a href="../../topic/{topics.slug}" itemprop="url">{topics.title}</a><br />
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
								<a href="../../user/{topics.teaser_userslug}">
									<img class="profile-image small" src="{topics.teaser_userpicture}" title="{topics.teaser_username}"/>
								</a>
								<a href="../../topic/{topics.slug}#{topics.teaser_pid}">
									[[category:replied]]
									<span class="timeago" title="{topics.teaser_timestamp}"></span>
								</a>
								<!-- ENDIF topics.unreplied -->
							</div>
						</div>
					</div>
				</div>
			</li>
			<!-- END topics -->
		</ul>
	</div>
	<div class="col-md-3 {show_sidebar} category-sidebar">
		<div class="panel panel-default">
			<div class="panel-heading">[[category:sidebar.recent_replies]]</div>
			<div class="panel-body recent-replies">
				<ul id="category_recent_replies"></ul>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">[[category:sidebar.active_participants]]</div>
			<div class="panel-body active-users">
				<!-- BEGIN active_users -->
				<a data-uid="{active_users.uid}" href="../../user/{active_users.userslug}"><img title="{active_users.username}" src="{active_users.picture}" class="img-rounded user-img" /></a>
				<!-- END active_users -->
			</div>
		</div>

		<div class="panel panel-default {moderator_block_class}">
			<div class="panel-heading">[[category:sidebar.moderators]]</div>
			<div class="panel-body moderators">
				<!-- BEGIN moderators -->
				<a href="../../user/{moderators.userslug}"><img title="{moderators.username}" src="{moderators.picture}" class="img-rounded" /></a>
				<!-- END moderators -->
			</div>
		</div>

		<!-- BEGIN sidebars -->
		<div class="panel panel-default">
			<div class="panel panel-default {sidebars.block_class}">{sidebars.header}</div>
			<div class="panel-body">{sidebars.content}</div>
		</div>
		<!-- END sidebars -->
	</div>
</div>

<input type="hidden" template-variable="category_id" value="{category_id}" />
<input type="hidden" template-variable="category_name" value="{category_name}" />