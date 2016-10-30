<div class="recent">
    <!-- IMPORT partials/breadcrumbs.tpl -->
    <div class="well text-center">
        <!-- IF !breadcrumbs.length -->
        <p>
             欢迎来到 V2MM 社区，这里是一个自由主义者聚集之地，我们在这里讨论技术，发表时评，分享创造， 取暖过冬。
        </p>
        <!-- ENDIF !breadcrumbs.length -->

        <!-- IF loggedIn -->
        <button component="category/post" id="new_topic" class="btn btn-success">[[v2mm:new_topic_button]]</button>
        <!-- ELSE -->
        <a component="category/post/guest" href="{config.relative_path}/login" class="btn btn-primary">[[category:guest-login-post]]</a>
        <!-- ENDIF loggedIn -->
    </div>

    <a href="{config.relative_path}/recent">
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
        <!-- IF config.usePagination -->
            <!-- IMPORT partials/paginator.tpl -->
        <!-- ENDIF config.usePagination -->
    </div>
</div>
