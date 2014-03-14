<div class="recent">
	<ol class="breadcrumb">
		<li><a href="{relative_path}/">[[global:home]]</a></li>
		<li class="active">[[recent:title]] <a href="{relative_path}/recent.rss"><i class="fa fa-rss-square"></i></a></li>
	</ol>

	<ul class="nav nav-pills">
		<li class=''><a href='{relative_path}/recent/day'>[[recent:day]]</a></li>
		<li class=''><a href='{relative_path}/recent/week'>[[recent:week]]</a></li>
		<li class=''><a href='{relative_path}/recent/month'>[[recent:month]]</a></li>
	</ul>

	<br />

	<a href="{relative_path}/recent">
		<div class="alert alert-warning hide" id="new-topics-alert"></div>
	</a>

	<!-- IF !topics.length -->
	<div class="alert alert-warning" id="category-no-topics">
		<strong>[[recent:no_recent_topics]]</strong>
	</div>
	<!-- ENDIF !topics.length -->

	<div class="category row">
		<div class="col-md-12">
			<!-- IMPORT partials/topics_list.tpl -->
		</div>
	</div>
</div>