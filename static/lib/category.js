'use strict';
/* globals require, ajaxify */
// override init and onTopicsLoaded of the category module.
require(['forum/category'], function (Org) {
    var orgInit = Org.init;
    var orgOnTopicLoaded = Org.onTopicsLoaded;
    var isCustomCategory;

    Org.onTopicsLoaded = function (data, direction, callback) {
        data.isCustom = isCustomCategory;
        return orgOnTopicLoaded.call(Org, data, direction, callback);
    };

    Org.init = function () {
        console.log('category init...');
        isCustomCategory = ajaxify.data && ajaxify.data.isCustom;
        return orgInit.call(Org);
    };
});
