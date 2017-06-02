<div class="inline-block">

    <span class="tags">
    <!-- BEGIN tags -->
    <a href="{config.relative_path}/tags/{tags.value}"><span class="tag-item" data-tag="{tags.value}" style="<!-- IF tags.color -->color: {tags.color};<!-- ENDIF tags.color --><!-- IF tags.bgColor -->background-color: {tags.bgColor};<!-- ENDIF tags.bgColor -->">{tags.value}</span><span class="tag-topic-count">{tags.score}</span></a>
    <!-- END tags -->
    </span>

    <small class="topic-stats">
        <!-- IF tags.length -->
        <span>&bull;</span>
        <!-- ENDIF tags.length -->
        <span><i title="[[global:posts]]" class="fa fa-comment-o"></i></span>
        <strong><span component="topic/post-count" class="human-readable-number" title="{postcount}">{postcount}</span></strong> &bull;
        <span><i title="[[global:views]]" class="fa fa-eye"></i></span>
        <strong><span class="human-readable-number" title="{viewcount}">{viewcount}</span></strong>
    </small>
    <span class="browsing-users hidden">
        &bull;
        <small><span>[[category:browsing]]</span></small>
        <div component="topic/browsing/list" class="thread_active_users active-users inline-block"></div>
        <small class="hidden">
            <i class="fa fa-users"></i> <span component="topic/browsing/count" class="user-count"></span>
        </small>
    </span>
</div>

<div class="topic-main-buttons pull-right inline-block">
    <div class="loading-indicator" done="0" style="display:none;">
        <span class="hidden-xs">[[v2mm:loading_more_posts]]</span>
        <i class="fa fa-refresh fa-spin"></i>
    </div>

    <!-- IMPORT partials/topic/reply-button.tpl -->
    <span class="hidden-xs hidden-sm">
        <!-- IMPORT partials/topic/watch.tpl -->

        <!-- IMPORT partials/topic/sort.tpl -->

        <!-- IMPORT partials/thread_tools.tpl -->

        <!-- IMPORT partials/label_tools.tpl -->
    </span>
</div>
<div style="clear:both;"></div>
