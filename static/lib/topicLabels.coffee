'use strict';

# globals define, app, ajaxify, bootbox, socket, templates, utils, config

define 'forum/topicLabelsTool', ['components', 'translator', 'topicSelect'], (omponents, translator, topicSelect) ->
    running = false

    return {
        init: () ->
            checkTopicLabel = (topic, labelName) ->
                return false if !topic.labels or !topic.labels.length
                return !!topic.labels.find((label)->label.name==labelName)

            $('.label-tools .toggle-label').click ()->
                labelName = $(this).data('name')
                if ajaxify.data.template.topic
                    tids = [String(ajaxify.data.tid)]
                else
                    tids = topicSelect.getSelectedTids()

                label = ajaxify.data.availabelLabels.find (label)->label.name==labelName
                return false if running or !tids.length or !label

                running = true

                if ajaxify.data.template.topic
                    if checkTopicLabel(ajaxify.data, labelName)
                        labeledTopics = [ajaxify.data]
                    else
                        labeledTopics = []
                else
                    labeledTopics = ajaxify.data.topics.filter((topic)->tids.indexOf(String(topic.tid))!=-1 and checkTopicLabel(topic, labelName))
                if labeledTopics.length == tids.length
                    action = 'remove'
                    msg = 'Remove label success.'
                else 
                    action = 'add'
                    msg = 'Add label success.'

                socket.emit 'plugins.v2mm.handleLabel', {action, label, tids}, (err)->
                    return app.alertError(err.message) if err

                    running = false
                    app.alertSuccess(msg)
                    ajaxify.refresh()

                return false

            $('.label-tools .removeAllLabels').click ()->
                bootbox.confirm 'Are you sure you wish to remove all labels?', (confirm)->
                    return unless confirm

                    if ajaxify.data.template.topic
                        tids = [String(ajaxify.data.tid)]
                    else
                        tids = topicSelect.getSelectedTids()

                    action = 'removeAll'
                    socket.emit 'plugins.v2mm.handleLabel', {action, tids}, (err)->
                        return app.alertError(err.message) if err

                        running = false
                        app.alertSuccess('Remove label success.')
                        ajaxify.refresh()

                return false


    }
