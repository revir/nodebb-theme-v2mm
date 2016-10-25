<!-- BEGIN users -->
<li class="users-box registered-user" data-uid="{users.uid}">
    <a href="{config.relative_path}/user/{users.userslug}">
        <!-- IF users.picture -->
        <img class="user-icon" src="{users.picture}" />
        <!-- ELSE -->
        <div class="user-icon" style="background-color: {users.icon:bgColor};">{users.icon:text}</div>
        <!-- ENDIF users.picture -->
    </a>
    <br/>
    <div class="user-info">
        <span>
            <i component="user/status" class="fa fa-circle status {users.status}" title="[[global:{users.status}]]"></i>
            <a href="{config.relative_path}/user/{users.userslug}">{users.username}</a>
        </span>
        <br/>
    </div>
</li>
<!-- END users -->
