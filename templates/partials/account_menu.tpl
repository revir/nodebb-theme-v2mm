
<!-- IMPORT partials/breadcrumbs.tpl -->

<div class="cover" component="account/cover" style="background-image: url({cover:url}); background-position: {cover:position};">
    <!-- IF showHidden -->
    <div class="controls">
        <span class="upload"><i class="fa fa-fw fa-4x fa-upload"></i></span>
        <span class="resize"><i class="fa fa-fw fa-4x fa-arrows-alt"></i></span>
        <span class="remove"><i class="fa fa-fw fa-4x fa-times"></i></span>
    </div>
    <div class="save">[[groups:cover-save]] <i class="fa fa-fw fa-floppy-o"></i></div>
    <div class="indicator">[[groups:cover-saving]] <i class="fa fa-fw fa-refresh fa-spin"></i></div>
    <!-- ENDIF showHidden -->
</div>

<div class="account-username-box" data-userslug="{userslug}" data-uid="{uid}">
    <ul class="nav nav-pills account-sub-links">
        <li>
            <a href="#" type="button" class="dropdown-toggle inline-block" data-toggle="dropdown">
                [[user:more]]
                <span class="caret"></span>
                <span class="sr-only">Toggle Dropdown</span>
            </a>
            <ul class="dropdown-menu pull-right" role="menu">
                <li><a href="{config.relative_path}/user/{userslug}/following"><i class="fa fa-fw fa-users"></i> [[user:following]]</a></li>
                <li><a href="{config.relative_path}/user/{userslug}/followers"><i class="fa fa-fw fa-users"></i> [[user:followers]]</a></li>
                <li class="divider"></li>
                <li><a href="{config.relative_path}/user/{userslug}/topics"><i class="fa fa-fw fa-book"></i> [[global:topics]]</a></li>
                <li><a href="{config.relative_path}/user/{userslug}/posts"><i class="fa fa-fw fa-pencil"></i> [[global:posts]]</a></li>
                <!-- IF !reputation:disabled -->
                <li><a href="{config.relative_path}/user/{userslug}/best"><i class="fa fa-fw fa-star"></i> [[global:best]]</a></li>
                <!-- ENDIF !reputation:disabled -->
                <li><a href="{config.relative_path}/user/{userslug}/groups"><i class="fa fa-fw fa-users"></i> [[global:header.groups]]</a></li>
                <!-- IF showHidden -->
                <li><a href="{config.relative_path}/user/{userslug}/bookmarks"><i class="fa fa-fw fa-heart"></i> [[user:bookmarks]]</a></li>
                <li><a href="{config.relative_path}/user/{userslug}/watched"><i class="fa fa-fw fa-eye"></i> [[user:watched]]</a></li>

                <!-- IF !reputation:disabled -->
                <li><a href="{config.relative_path}/user/{userslug}/upvoted"><i class="fa fa-fw fa-chevron-up"></i> [[global:upvoted]]</a></li>
                <!-- IF !downvote:disabled -->
                <li><a href="{config.relative_path}/user/{userslug}/downvoted"><i class="fa fa-fw fa-chevron-down"></i> [[global:downvoted]]</a></li>
                <!-- ENDIF !downvote:disabled -->
                <!-- ENDIF !reputation:disabled -->

                <li><a href="{config.relative_path}/user/{userslug}/info"><i class="fa fa-fw fa-lock"></i> [[user:account_info]]</a></li>

                <!-- ENDIF showHidden -->
                <!-- BEGIN profile_links -->
                <li id="{profile_links.id}" class="plugin-link <!-- IF profile_links.public -->public<!-- ELSE -->private<!-- ENDIF profile_links.public -->"><a href="{config.relative_path}/user/{userslug}/{profile_links.route}"><i class="fa fa-fw {profile_links.icon}"></i> {profile_links.name}</a></li>
                <!-- END profile_links -->
            </ul>
        </li>
        <li>
            <a href="{config.relative_path}/user/{userslug}" class="inline-block" id="profile"><i class="fa fa-user"></i> [[user:profile]]</a>
        </li>
        <!-- IF showHidden -->
        <li><a href="{config.relative_path}/user/{userslug}/settings"><i class="fa fa-gear"></i> [[user:settings]]</a></li>
        <li><a href="{config.relative_path}/user/{userslug}/edit"><i class="fa fa-pencil-square-o"></i> [[user:edit]]</a></li>
        <!-- ENDIF showHidden -->
    </ul>
</div>
