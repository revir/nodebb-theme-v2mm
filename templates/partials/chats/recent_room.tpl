<li data-roomid="{rooms.roomId}" class="hidden-sm hidden-xs <!-- IF rooms.unread -->unread<!-- ENDIF rooms.unread -->">
    <div class="chat-header-wrapper clearfix">
        <div class="chat-members-wrapper pull-left">
            <ul class="members">
                <!-- BEGIN rooms.users -->
                <li>
                    <a href="{config.relative_path}/user/{rooms.users.userslug}">
                        <!-- IF rooms.users.picture -->
                        <img class="user-img avatar avatar-sm avatar-rounded" src="{rooms.users.picture}" title="{rooms.users.username}">
                        <!-- ELSE -->
                        <div class="user-img avatar avatar-sm avatar-rounded" title="{rooms.users.username}" style="background-color: {rooms.users.icon:bgColor};">{rooms.users.icon:text}</div>
                        <!-- ENDIF rooms.users.picture -->
                    </a>
                </li>
                <!-- END rooms.users -->
                <!-- IF !rooms.lastUser.uid -->
                <li>[[modules:chat.no-users-in-room]]</li>
                <!-- ENDIF !rooms.lastUser.uid -->
            </ul>
        </div>

        <i class="fa fa-times pull-right chat-actions leave-room"></i>
        <span class="teaser-timestamp timeago pull-right text-muted small chat-actions switch-room" title="{rooms.teaser.timestampISO}"></span>
    </div>
    <span class="teaser-content chat-actions switch-room">{rooms.teaser.content}</span>
</li>

<li data-roomid="{rooms.roomId}" class="visible-xs visible-sm <!-- IF rooms.unread -->unread<!-- ENDIF rooms.unread -->">
    <div class="chat-header-wrapper clearfix">
        <div class="chat-members-wrapper pull-left">
            <ul class="members">
                <!-- BEGIN rooms.users -->
                <li>
                    <a href="{config.relative_path}/user/{rooms.users.userslug}">
                        <!-- IF rooms.users.picture -->
                        <img class="user-img avatar avatar-sm avatar-rounded" src="{rooms.users.picture}" title="{rooms.users.username}">
                        <!-- ELSE -->
                        <div class="user-img avatar avatar-sm avatar-rounded" title="{rooms.users.username}" style="background-color: {rooms.users.icon:bgColor};">{rooms.users.icon:text}</div>
                        <!-- ENDIF rooms.users.picture -->
                    </a>
                </li>
                <!-- END rooms.users -->
                <!-- IF !rooms.lastUser.uid -->
                <li>[[modules:chat.no-users-in-room]]</li>
                <!-- ENDIF !rooms.lastUser.uid -->
            </ul>
        </div>
        <i class="fa fa-times pull-right chat-actions leave-room"></i>
        <span class="teaser-timestamp timeago pull-right text-muted small chat-actions directly-open-chat" title="{rooms.teaser.timestampISO}"></span>
    </div>
    <span class="teaser-content chat-actions directly-open-chat">{rooms.teaser.content}</span>
</li>

