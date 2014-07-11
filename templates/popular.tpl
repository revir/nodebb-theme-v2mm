<div class="popular">
	<ol class="breadcrumb">
		<li><a href="{relative_path}/">Home</a></li>
		<li class="active">[[global:header.popular]] <a href="{relative_path}/popular.rss"><i class="fa fa-rss-square"></i></a></li>
	</ol>

	<ul class="nav nav-pills">
		<li><a href='{relative_path}/popular/daily'>[[recent:day]]</a></li>
		<li><a href='{relative_path}/popular/weekly'>[[recent:week]]</a></li>
		<li><a href='{relative_path}/popular/monthly'>[[recent:month]]</a></li>
		<li><a href='{relative_path}/popular/yearly'>[[recent:year]]</a></li>
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