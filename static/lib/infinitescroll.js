'use strict';
/* globals require, ajaxify */
require(['forum/infinitescroll'], function (Org) {
    var loadMore = Org.loadMore;
    var callback;
    var $spin;

    function myCallBack() {
        $spin.fadeOut(300, function(){ $(this).remove();});

        callback.apply(Org, arguments);
    }

    Org.loadMore = function (method, data, cb) {
        console.log('infinitescroll loadmore...');
        $spin = $('.v2mm-loading-spin');
        $spin.removeClass('hidden');
        callback = cb;
        return loadMore.call(Org, method, data, myCallBack);
    };
});
