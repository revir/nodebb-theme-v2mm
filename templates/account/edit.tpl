<div class="account">
    <!-- IMPORT partials/account_menu.tpl -->

    <div class="row">
        <div class="col-md-2 col-sm-4">
            <div class="account-picture-block text-center">
                <!-- IF picture -->
                <img id="user-current-picture" class="user-profile-picture" src="{picture}" />
                <!-- ELSE -->
                <div class="user-icon user-profile-picture" style="background-color: {icon:bgColor};">{icon:text}</div>
                <!-- ENDIF picture -->
                <ul class="list-group">
                    <a id="changePictureBtn" href="#" class="list-group-item">[[user:change_picture]]</a>
                    <!-- IF !username:disableEdit -->
                    <a href="{config.relative_path}/user/{userslug}/edit/username" class="list-group-item">[[user:change_username]]</a>
                    <!-- ENDIF !username:disableEdit -->
                    <!-- IF !email:disableEdit -->
                    <a href="{config.relative_path}/user/{userslug}/edit/email" class="list-group-item">[[user:change_email]]</a>
                    <!-- ENDIF !email:disableEdit -->
                    <!-- IF canChangePassword -->
                    <a href="{config.relative_path}/user/{userslug}/edit/password" class="list-group-item">[[user:change_password]]</a>
                    <!-- ENDIF canChangePassword -->
                    <!-- BEGIN editButtons -->
                    <a href="{config.relative_path}{editButtons.link}" class="list-group-item">{editButtons.text}</a>
                    <!-- END editButtons -->
                </ul>

                <!-- IF config.requireEmailConfirmation -->
                <!-- IF email -->
                <!-- IF isSelf -->
                <a id="confirm-email" href="#" class="btn btn-warning <!-- IF email:confirmed -->hide<!-- ENDIF email:confirmed -->">[[user:confirm_email]]</a><br/><br/>
                <!-- ENDIF isSelf -->
                <!-- ENDIF email -->
                <!-- ENDIF config.requireEmailConfirmation -->

                <!-- IF allowAccountDelete -->
                <!-- IF isSelf -->
                <a id="deleteAccountBtn" href="#" class="btn btn-danger">[[user:delete_account]]</a><br/><br/>
                <!-- ENDIF isSelf -->
                <!-- ENDIF allowAccountDelete -->

            </div>
        </div>

        <div class="col-md-5 col-sm-4">
            <div>
                <form class='form-horizontal'>

                    <div class="control-group">
                        <label class="control-label" for="inputFullname">[[user:fullname]]</label>
                        <div class="controls">
                            <input class="form-control" type="text" id="inputFullname" placeholder="[[user:fullname]]" value="{fullname}">
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="inputLocation">[[user:location]]</label>
                        <div class="controls">
                            <input class="form-control" type="text" id="inputLocation" placeholder="[[user:location]]" value="{location}">
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="inputBirthday">[[user:birthday]]</label>
                        <div class="controls">
                            <input class="form-control" id="inputBirthday" value="{birthday}" placeholder="yyyy-mm-dd">
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="grouptitle">[[user:grouptitle]]</label>
                        <div class="controls">
                            <select class="form-control" id="groupTitle" data-property="groupTitle">
                                <option value="">[[user:no-group-title]]</option>
                                <!-- BEGIN groups -->
                                <!-- IF groups.userTitleEnabled -->
                                <option value="{groups.name}" <!-- IF groups.selected -->selected<!-- ENDIF groups.selected -->>{groups.userTitle}</option>
                                <!-- ENDIF groups.userTitleEnabled -->
                                <!-- END groups -->
                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="inputAboutMe">[[user:aboutme]]</label> <small><label id="aboutMeCharCountLeft"></label></small>
                        <div class="controls">
                            <textarea class="form-control" id="inputAboutMe" rows="5">{aboutme}</textarea>
                        </div>
                    </div>
                    <!-- IF !disableSignatures -->
                    <div class="control-group">
                        <label class="control-label" for="inputSignature">[[user:signature]]</label> <small><label id="signatureCharCountLeft"></label></small>
                        <div class="controls">
                            <textarea class="form-control" id="inputSignature" rows="3">{signature}</textarea>
                        </div>
                    </div>
                    <!-- ENDIF !disableSignatures -->

                    <div class="control-group">
                        <label class="control-label" for="inputWebsite">[[user:website]]</label>
                        <div class="controls">
                            <input class="form-control" type="text" id="inputWebsite" placeholder="http://..." value="{website}">
                        </div>
                    </div>

                    <!-- BEGIN extraSites -->
                    <div class="control-group">
                        <label class="control-label" for="{extraSites.name}">
                        <span class="fa-stack">
                            <i class="fa fa-circle fa-stack-2x"></i>
                            <i class="fa fa-stack-1x fa-inverse {extraSites.fa}">{extraSites.faText}</i>
                        </span>
                        {extraSites.name}
                        </label>
                        <div class="controls">
                            <input class="form-control extra-site-control" type="text" id="{extraSites.name}" placeholder="http://..." value="{extraSites.value}">
                        </div>
                    </div>
                    <!-- END extraSites -->

                    <input type="hidden" id="inputUID" value="{uid}"><br />

                    <div class="form-actions">
                        <a id="submitBtn" href="#" class="btn btn-primary">[[global:save_changes]]</a>
                    </div>

                </form>
            </div>

            <hr class="visible-xs visible-sm"/>
        </div>

        <div class="col-md-5 col-sm-4">
            <!-- IF sso.length -->
            <label class="control-label">[[user:sso.title]]</label>
            <div class="list-group">
                <!-- BEGIN sso -->
                <a class="list-group-item" href="{../url}" target="<!-- IF ../associated -->_blank<!-- ELSE -->_top<!-- ENDIF ../associated -->">
                    <!-- IF ../icon --><i class="fa {../icon}"></i><!-- ENDIF ../icon -->
                    <!-- IF ../associated -->[[user:sso.associated]]<!-- ELSE -->[[user:sso.not-associated]]<!-- ENDIF ../associated -->
                    {../name}
                </a>
                <!-- END sso -->
            </div>
            <!-- ENDIF sso.length -->
        </div>
    </div>
</div>

