<div class="category row">
	<!-- IF isCustom -->
	<div class="col-sm-12">
	<!-- ELSE -->
	<div class="col-md-9" no-widget-class="col-lg-12 col-sm-12" no-widget-target="sidebar">
		<!-- IMPORT partials/breadcrumbs.tpl -->
	<!-- ENDIF isCustom -->

		<div class="header category-tools clearfix">
			<div
				id="category-{cid}" class="category-header category-header-image category-header-image-{imageClass} pull-left"
				style="
					<!-- IF backgroundImage -->background-image: url({backgroundImage});<!-- ENDIF backgroundImage -->
					<!-- IF bgColor -->background-color: {bgColor};<!-- ENDIF bgColor -->
					color: {color};
				"
			>
				<!-- IF icon -->
				<div><i class="fa {icon} fa-2x"></i></div>
				<!-- ENDIF icon -->
			</div>

			<div class="hidden-xs hidden-sm pull-right" component="category/controls">
				<!-- IMPORT partials/category_watch.tpl -->

				<!-- IMPORT partials/category_sort.tpl -->

				<!-- IMPORT partials/category_tools.tpl -->
			</div>
			<p class="description">
				{description}
			</p>

			<div class="twrapper hidden-xs">
				<div>
					<!-- IF privileges.topics:create -->
					<!-- IF !children.length -->
					<button class="btn btn-success new_topic">[[v2mm:new_topic_button]]</button>
					<!-- ENDIF !children.length -->
					<!-- ENDIF privileges.topics:create -->

					<span class="sub-wrapper">
					<!-- BEGIN children -->
					<!-- IF @first -->
					<i class="fa fa-angle-right" aria-hidden="true"></i>
					<!-- ENDIF @first -->
					<a class="children-name" href="{config.relative_path}/category/{children.slug}" itemprop="url">
						{children.name}
					</a>
					<!-- END children -->
					</span>
				</div>
			</div>
		</div>

		<!-- IF !topics.length -->
		<div class="alert alert-warning" id="category-no-topics">
			[[category:no_topics]]
		</div>
		<!-- ENDIF !topics.length -->

		<!-- IMPORT partials/topics_list.tpl -->

		<!-- IF config.usePagination -->
			<!-- IMPORT partials/paginator.tpl -->
		<!-- ENDIF config.usePagination -->
	</div>

	<div widget-area="sidebar" class="col-md-3 col-xs-12 category-sidebar"></div>
</div>

<!-- IMPORT partials/move_thread_modal.tpl -->

<!-- IF !config.usePagination -->
<noscript>
	<!-- IMPORT partials/paginator.tpl -->
</noscript>
<!-- ENDIF !config.usePagination -->
