"use strict"

async = require('async')
meta = require.main.require('./src/meta')
db = require.main.require('./src/database')
winston = require('winston')
SocketPlugins = require.main.require('./src/socket.io/plugins')
User = require.main.require('./src/user')
Topics = require.main.require('./src/topics')
Privileges = require.main.require('./src/privileges')
Posts = require.main.require('./src/posts')
notifications = require.main.require('./src/notifications')
S = require('string')
utils = require.main.require('./public/src/utils')
_ = require('underscore')

((TopicLabel)->
    TopicLabel.canCreate = (cid, uid, callback)->
        Privileges.categories.can 'label:create', cid, uid, (err, can)->
            if err or !can
                return callback(new Error('[[v2mm:error.privilege.label.create]]'), can)
            else
                return callback(null, can)

    TopicLabel.create = (name, data, uid, callback) ->
        if !name || name.length < (meta.config.minimumLabelLength || 2)
            return setImmediate(callback, new Error('[[v2mm:invalid-label-name]]'))
        
        cleanName = utils.cleanUpTag(name, meta.config.maximumLabelLength || 255)
        hash = {value: name, name: cleanName}
        hash.color = data.color
        hash.bkColor = data.bkColor
        isMember = false
        async.waterfall [
            (next) ->
                db.isSortedSetMember 'labels:topic:count', cleanName, next

            (_isMember, next) ->
                isMember = _isMember
                if not isMember
                    hash.createtime = Date.now()
                    hash.createby = uid

                db.setObject 'label:'+cleanName, hash, next

            (next) ->
                if isMember
                    return next()

                db.sortedSetAdd 'labels:topic:count', 0, cleanName, next

        ], callback 

    TopicLabel.remove = (data, callback) ->
        unless data?.name and data.value
            return setImmediate(callback, new Error('[[v2mm:invalid-label-name]]'))

        async.waterfall [
            (next) ->
                db.getSetMembers 'label:'+data.name+':topics', next
            (tids, next) ->
                _fn = (tid, _cb)->
                    db.setRemove 'topic:'+tid+':labels', data.name, _cb

                async.each tids, _fn, next
            (next) ->
                db.sortedSetRemove 'labels:topic:count', data.name, next
            (next) ->
                db.delete 'label:'+data.name+':topics', next
            (next) ->
                db.delete 'label:'+data.name, next

        ], callback

    TopicLabel.addToTopic = (tid, data, callback) ->
        unless data?.name and data.value
            return callback(new Error('[[v2mm:error.invalid-label-name]]'))

        async.parallel [
            (next) ->
                db.setAdd 'label:'+data.name+':topics', tid, next

            (next) ->
                db.setAdd 'topic:'+tid+':labels', data.name, next

        ], (err, ret) -> 
            return callback(err) if err
            TopicLabel.updateLabelsTopicCount data.name, callback


    TopicLabel.removeFromTopic = (tid, data, callback) ->
        unless data?.name and data.value
            return callback(new Error('[[v2mm:error.invalid-label-name]]'))

        async.parallel [
            (next) ->
                db.setRemove 'label:'+data.name+':topics', tid, next

            (next) ->
                db.setRemove 'topic:'+tid+':labels', data.name, next

        ], (err, ret) -> 
            return callback(err) if err
            TopicLabel.updateLabelsTopicCount data.name, callback


    TopicLabel.removeTopicLabels = (tid, callback) ->
        labels = []
        async.waterfall [
            (next) ->
                db.getSetMembers 'topic:'+tid+':labels', next

            (_labels, next) ->
                labels = _labels
                sets = labels.map (lb) -> return 'label:'+lb+':topics'
                db.setsRemove sets, tid, next

            (next) ->
                async.each labels, TopicLabel.updateLabelsTopicCount, next

            (next) ->
                db.delete('topic:' + tid + ':labels', next)

        ], callback

    TopicLabel.updateLabelsTopicCount = (label, callback) ->
        async.waterfall [
            (next) ->
                db.setCount('label:'+label+':topics', next)
            (count, next) ->
                db.sortedSetAdd 'labels:topic:count', count, label, next
        ], callback

    TopicLabel.getTopicsLabels = (tids, callback) ->
        sets = tids.map (tid) -> return 'topic:'+tid+':labels'
        topicsLabels = uniqueTopicsLabels = null

        async.waterfall [
            (next) ->
                db.getSetsMembers sets, next
            (_topicsLabels, next) ->
                topicsLabels = _topicsLabels
                uniqueTopicsLabels = _.uniq(_.flatten(topicsLabels))

                keys = uniqueTopicsLabels.map (label)->'label:'+label

                db.getObjects keys, next

        ], (err, labelsData) ->
            return callback(err) if err
            labelsData = _.object(uniqueTopicsLabels, labelsData)

            topicsLabels.forEach (labels, index)->
                if Array.isArray(labels)
                    topicsLabels[index] = labels.map (label)->
                        return labelsData[label] 

            return callback(null, topicsLabels)

    TopicLabel.getAvailabelLabels = (callback) ->
        async.waterfall [
            (next) ->
                db.getSortedSetRevRange('labels:topic:count', 0, -1, next)
            (labels, next)->
                keys = labels.map (label) ->'label:'+label
                db.getObjects keys, next
        ], callback


)(exports)
