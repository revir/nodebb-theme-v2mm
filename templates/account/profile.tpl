<div class="account">
    <!-- IMPORT partials/account_menu.tpl -->

    <div class="row">
        <div class="col-md-5 account-block">

            <div class="account-picture-block panel panel-default">
                <div class="panel-body">
                    <div class="text-center">
                        <!-- IF picture -->
                        <img src="{picture}" class="user-profile-picture" />
                        <!-- ELSE -->
                        <div class="user-icon user-profile-picture" style="background-color: {icon:bgColor};" title="{username}">{icon:text}</div>
                        <!-- ENDIF picture -->
                        <i class="fa fa-circle status {status}" title="[[global:{status}]]"></i>
                    </div>

                    <div>
                        <div class="text-center">
                            <h2 class="fullname">
                            <!-- IF fullname -->{fullname}<!-- ELSE -->{username}<!-- ENDIF fullname -->
                            <small>
                                (@{username})
                            </small>
                            </h2>

                            <!-- IF !isSelf -->
                            <br/>
                            <!-- IF !config.disableChat -->
                            <a component="account/chat" href="#" class="btn btn-primary btn-sm">[[user:chat]]</a>
                            <!-- ENDIF !config.disableChat -->
                            <a component="account/follow" href="#" class="btn btn-success btn-sm <!-- IF isFollowing -->hide<!-- ENDIF isFollowing -->">[[user:follow]]</a>
                            <a component="account/unfollow" href="#" class="btn btn-warning btn-sm <!-- IF !isFollowing -->hide<!-- ENDIF !isFollowing -->">[[user:unfollow]]</a>

                            <!-- IF canBan -->
                            <br/><br/>
                            <a component="account/ban" href="#" class="btn btn-danger btn-sm <!-- IF banned -->hide<!-- ENDIF banned -->">[[user:ban_account]]</a>
                            <a component="account/unban" href="#" class="btn btn-danger btn-sm <!-- IF !banned -->hide<!-- ENDIF !banned -->">[[user:unban_account]]</a>
                            <!-- ENDIF canBan -->
                            <!-- IF isAdmin -->
                            <a component="account/delete" href="#" class="btn btn-danger btn-sm">[[user:delete_account]]</a><br/><br/>
                            <!-- ENDIF isAdmin -->
                            <!-- ENDIF !isSelf -->

                        </div>

                        <div id="banLabel" class="text-center <!-- IF !banned -->hide<!-- ENDIF !banned -->">
                            <span class="label label-danger">[[user:banned]]</span>
                        </div>

                        <!-- IF aboutme -->
                        <hr/>
                        <div component="aboutme" class="text-center">
                        {aboutme}
                        </div>
                        <!-- ENDIF aboutme -->
                        <hr/>
                        <div class="text-center account-stats">

                            <!-- IF !reputation:disabled -->
                            <div class="inline-block text-center">
                                <span class="human-readable-number" title="{reputation}">{reputation}</span>
                                <span class="account-bio-label">[[global:reputation]]</span>
                            </div>
                            <!-- ENDIF !reputation:disabled -->

                            <div class="inline-block text-center">
                                <span class="human-readable-number" title="{postcount}">{postcount}</span>
                                <span class="account-bio-label">[[global:posts]]</span>
                            </div>

                            <div class="inline-block text-center">
                                <span class="human-readable-number" title="{profileviews}">{profileviews}</span>
                                <span class="account-bio-label">[[user:profile_views]]</span>
                            </div>

                            <div class="inline-block text-center">
                                <span class="human-readable-number" title="{followerCount}">{followerCount}</span>
                                <span class="account-bio-label">[[user:followers]]</span>
                            </div>
                        </div>

                        <hr/>
                        <div class="text-center extra-sites">
                            <ul class="list-inline">
                                <!-- BEGIN extraSites -->
                                <!-- IF extraSites.value -->
                                <li>
                                    <a href="{extraSites.value}" title="{extraSites.name}" target="_blank" rel="nofollow">
                                        <span class="fa-stack">
                                            <i class="fa fa-circle fa-stack-2x"></i>
                                            <i class="fa fa-stack-1x fa-inverse {extraSites.fa}">{extraSites.faText}</i>
                                        </span>
                                    </a>
                                </li>
                                <!-- ENDIF extraSites.value -->
                                <!-- END extraSites -->
                            </ul>
                        </div>

                        <hr/>
                        <div class="text-center profile-meta">
                            <!-- IF email -->
                            <span><i class="fa fa-envelope-open-o" aria-hidden="true"></i></span>
                            <strong><i class="fa fa-eye-slash {emailClass}" title="[[user:email_hidden]]"></i> {email}</strong>
                            <br/>
                            <!-- ENDIF email -->

                            <!-- IF websiteName -->
                            <span><i class="fa fa-edge" aria-hidden="true"></i></span>
                            <strong><a href="{websiteLink}" target="_blank" rel="nofollow">{websiteName}</a></strong>
                            <br/>
                            <!-- ENDIF websiteName -->

                            <!-- IF location -->
                            <span><i class="fa fa-location-arrow" aria-hidden="true"></i></span>
                            <strong>{location}</strong>
                            <br/>
                            <!-- ENDIF location -->

                            <span>[[user:joined]]</span>
                            <span class="timeago text-muted" title="{joindateISO}"></span>
                            <br>
                            <span>[[user:lastonline]]</span>
                            <span class="timeago text-muted" title="{lastonlineISO}"></span>
                        </div>

                        <!-- IF !disableSignatures -->
                        <!-- IF signature -->
                        <hr/>
                        <span class="account-bio-label">[[user:signature]]</span>
                        <div class="post-signature">
                            <span id='signature'>{signature}</span>
                        </div>
                        <!-- ENDIF signature -->
                        <!-- ENDIF !disableSignatures -->
                    </div>
                </div>
            </div>

            <!-- IF groups.length -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">[[groups:groups]]</h3>
                </div>
                <div class="panel-body">
                <!-- BEGIN groups -->
                    <a href="{config.relative_path}/groups/{groups.slug}"><span class="label group-label inline-block" style="background-color: {groups.labelColor};"><!-- IF groups.icon --><i class="fa {groups.icon}"></i> <!-- ENDIF groups.icon -->{groups.userTitle}</span></a>
                <!-- END groups -->
                </div>
            </div>
            <!-- ENDIF groups.length -->

        </div>

        <div class="col-md-7">
        <!-- IF !posts.length -->
        <div class="alert alert-warning">[[user:has_no_posts]]</div>
        <!-- ENDIF !posts.length -->
        <!-- IMPORT partials/posts_list.tpl -->
        <!-- IF config.usePagination -->
            <!-- IMPORT partials/paginator.tpl -->
        <!-- ENDIF config.usePagination -->
        </div>

    </div>

    <br/>
    <div id="user-action-alert" class="alert alert-success hide"></div>

</div>
