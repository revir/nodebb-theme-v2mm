    </div><!-- END container -->

    <div class="hide">
    <!-- IMPORT 500-embed.tpl -->
    </div>

    <div class="topic-search hidden">
        <div class="btn-group">
            <button type="button" class="btn btn-default count"></button>
            <button type="button" class="btn btn-default prev"><i class="fa fa-fw fa-angle-up"></i></button>
            <button type="button" class="btn btn-default next"><i class="fa fa-fw fa-angle-down"></i></button>
        </div>
    </div>

    <div component="toaster/tray" class="alert-window">
        <div id="reconnect-alert" class="alert alert-dismissable alert-warning clearfix hide" component="toaster/toast">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <p>[[global:reconnecting-message, {config.siteTitle}]]</p>
        </div>
    </div>

    <div class="ajaxifying-effect hidden">
        <img src="https://v2mm-upload.b0.upaiyun.com/images/79bdab01-0aa5-4ace-82e0-ad398c5708d0.png" alt="" class="fish">
        <div class="bubbles bubble-1"></div>
        <div class="bubbles bubble-5"></div>
        <div class="bubbles bubble-2"></div>
        <div class="bubbles bubble-6"></div>
        <div class="bubbles bubble-3"></div>
        <div class="bubbles bubble-7"></div>
        <div class="bubbles bubble-4"></div>
        <div class="bubbles bubble-8"></div>
        <div class="bubbles bubble-9"></div>
        <div class="bubbles bubble-10"></div>
        <div class="bubbles bubble-11"></div>
    </div>

    <script>
        require(['forum/footer']);
    </script>
</body>
</html>
