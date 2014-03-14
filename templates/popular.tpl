<div class="popular">
	<ol class="breadcrumb">
		<li><a href="{relative_path}/">Home</a></li>
		<li class="active">[[global:header.popular]] <a href="{relative_path}/popular.rss"><i class="fa fa-rss-square"></i></a></li>
	</ol>

	<ul class="nav nav-pills">
		<li class=''><a href='{relative_path}/popular/posts'>[[global:posts]]</a></li>
		<li class=''><a href='{relative_path}/popular/views'>[[global:views]]</a></li>
	</ul>

	<br />

	<a href="{relative_path}/popular">
		<div class="alert alert-warning hide" id="new-topics-alert"></div>
	</a>

	<!-- IF !topics.length -->
	<div class="alert alert-warning" id="category-no-topics">
		<strong>There are no popular topics.</strong>
	</div>
	<!-- ENDIF !topics.length -->


	<div class="category row">
		<div class="col-md-12">
			<!-- IMPORT partials/topics_list.tpl -->
		</div>
	</div>
</div>