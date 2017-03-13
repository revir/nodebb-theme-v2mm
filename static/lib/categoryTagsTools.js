'use strict';
/* globals require, app, bootbox, socket */

define('forum/categoryTagsTools', ['composer/tags', 'topicSelect', 'components'], function (ComposerTags, topicSelect, components) {
    var categoryTagsTools = {};
    console.log('categoryTagsTools enter....');

    function openModal(cid, tids) {
      app.parseAndTranslate('modals/add-tags', {}, function (html) {
        var modal = bootbox.dialog({
          size: 'large',
          title: 'Add tags to selected topics',
          message: html,
          show: true,
          onEscape: true,
          buttons: {
            'cancel': {
              label: 'Cancel',
              className: 'btn-primary',
              callback: function callback() {}
            },
            'accept': {
              label: 'Save Tags',
              className: 'btn-default',
              callback: function callback() {
                var tags = modal.find('.tags').tagsinput('items');

                socket.emit('plugins.v2mm.addTagsToTopics', {
                    cid: cid,
                    tids: tids,
                    tags: tags
                }, function (err) {
                  if (err) return app.alertError(err.message);

                  app.alertSuccess('Add tags succeed.');

                  //close dropdown;
                  $('.thread-tools.open').find('.dropdown-toggle').trigger('click');

                });
              }
            }
          }
        });

        ComposerTags.init(modal, {cid: cid});
      });
    }

    categoryTagsTools.init = function (cid) {
        console.log('categoryTagsTools init....');
        components.get('topic/add-tags').on('click', function () {
            var tids = topicSelect.getSelectedTids();
            if (cid && tids.length) {
               app.loadJQueryUI(function () {
                   openModal(cid, tids);
               });
            }
            return false;
        });
    };
    return categoryTagsTools;
});
