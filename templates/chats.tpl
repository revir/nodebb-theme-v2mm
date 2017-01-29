
<!-- IMPORT partials/breadcrumbs.tpl -->

<div class="row">

    <div class="col-md-3 col-sm-12 col-xs-12 pull-right">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="chat-search">
                    <input class="form-control" type="text" component="chat/search" placeholder="[[users:enter_username]]" />
                </div>
                <ul component="chat/search/list" class="chat-search-list">

                </ul>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h2 class="panel-title">[[modules:chat.recent-chats]]</h2>
            </div>
            <div class="panel-body">
                <ul component="chat/recent" class="chats-list" data-nextstart="{nextStart}">
                    <!-- BEGIN rooms -->
                    <!-- IMPORT partials/chats/recent_room.tpl -->
                    <!-- END rooms -->
                </ul>
            </div>
        </div>
    </div>

    <div class="col-md-9 hidden-sm hidden-xs">
        <!-- IF roomId -->
        <div component="chat/messages" class="panel panel-default expanded-chat" data-roomid="{roomId}">
            <div class="panel-heading">
                <button type="button" class="close" data-action="pop-out"><span aria-hidden="true"><i class="fa fa-compress"></i></span><span class="sr-only">[[modules:chat.pop-out]]</span></button>
                <h2 class="panel-title">[[modules:chat.message-history]]</h2>
            </div>
            <div class="panel-body">
                <!-- IF showUserInput -->
                <div class="users-tag-container">
                    <input class="users-tag-input" type="text" class="form-control" placeholder="enter users here" tabindex="4"/>
                </div>
                <!-- ENDIF showUserInput -->

                <ul class="chat-content">
                    <!-- IMPORT partials/chats/messages.tpl -->
                </ul>
                <div class="input-group">
                    <textarea component="chat/input" placeholder="[[modules:chat.placeholder]]" class="form-control chat-input mousetrap" rows="1"></textarea>
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="button" data-action="send">[[modules:chat.send]]</button>
                    </span>
                </div>
            </div>
        </div>
        <!-- ELSE -->
        <div class="alert alert-info">
            [[modules:chat.no-messages]]
        </div>
        <!-- ENDIF roomId -->
    </div>

</div>
