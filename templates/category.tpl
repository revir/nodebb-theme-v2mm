<div class="category row">
	<div class="col-md-9" no-widget-class="col-lg-12 col-sm-12" no-widget-target="sidebar">

		<!-- IMPORT partials/breadcrumbs.tpl -->

		<div class="header category-tools clearfix row">
			<div class="col-md-7 col-xs-12">
					<div
						id="category-{cid}" class="category-header category-header-image category-header-image-{imageClass} pull-left"
						style="
							<!-- IF backgroundImage -->background-image: url({backgroundImage});<!-- ENDIF backgroundImage -->
							<!-- IF bgColor -->background-color: {bgColor};<!-- ENDIF bgColor -->
							color: {color};
						"
					></div>

					<div class="twrapper">
						<p class="text-muted description">
							{description}
						</p>

						<div>
							<!-- IF privileges.topics:create -->
							<button id="new_topic" class="btn btn-success">[[v2mm:new_topic_button]]</button>
							<!-- ELSE -->
								<!-- IF !loggedIn -->
								<a href="{config.relative_path}/login" class="btn btn-success">[[category:guest-login-post]]</a>
								<!-- ENDIF !loggedIn -->
							<!-- ENDIF privileges.topics:create -->

							<span class="sub-wrapper">
							<!-- BEGIN children -->
							<!-- IF @first -->
							<span class="text-muted split-text"> | </span>
							<!-- ENDIF @first -->
							<a class="children-name" href="{config.relative_path}/category/{children.slug}" itemprop="url">
								{children.name}
							</a>
							<!-- END children -->
							</span>
						</div>
					</div>
				</span>
			</div>
			<div class="col-md-5 col-xs-12">
				<span class="pull-right" component="category/controls">
					<!-- IMPORT partials/category_watch.tpl -->

					<!-- IMPORT partials/category_sort.tpl -->

					<!-- IMPORT partials/category_tools.tpl -->
				</span>
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

	<!-- IF topics.length -->
	<div widget-area="sidebar" class="col-md-3 col-xs-12 category-sidebar"></div>
	<!-- ENDIF topics.length -->
</div>

<!-- IMPORT partials/move_thread_modal.tpl -->

<!-- IF !config.usePagination -->
<noscript>
	<!-- IMPORT partials/paginator.tpl -->
</noscript>
<!-- ENDIF !config.usePagination -->
