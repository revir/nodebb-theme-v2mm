'use strict';
/* globals require, app, bootbox, socket */

define('forum/categoryTagsTools', ['composer/tags', 'topicSelect', 'components'], function (ComposerTags, topicSelect, components) {
    var categoryTagsTools = {};
    console.log('categoryTagsTools enter....');

    function openModal(data, tids) {
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
                    tids: tids,
                    tags: tags
                }, function (err) {
                  if (err) return app.alertError(err.message);

                  app.alertSuccess('Add tags succeed.');

                  //close dropdown;
                  $('.thread-tools.open').find('.dropdown-toggle').trigger('click');

                  if (data.tid) {
                    ajaxify.refresh();
                  }

                });
              }
            }
          }
        });

        ComposerTags.init(modal, data);
      });
    }

    function handler () {
      var tids;
      if (ajaxify.data.tid) {
         tids = [ajaxify.data.tid];
      } else {
         tids = topicSelect.getSelectedTids();
      }
      if (tids.length) {
         app.loadJQueryUI(function () {
             openModal(ajaxify.data, tids);
         });
      }
      return false;
    }
        // $(document).off('click', '[component="topic/add-tags"]', handler);
    $(document).on('click', '[component="topic/add-tags"]', handler);
    return categoryTagsTools;
});
