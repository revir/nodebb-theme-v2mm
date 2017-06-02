define 'admin/plugins/v2mm', ['admin/settings', 'admin/modules/colorpicker'], (Settings, colorpicker) ->
    ACP = {}

    getItem = (name)->
        ajaxify.data.availabelLabels.find (item)->
            return item.name == name

    ACP.init = () ->
        $("#create-label").on 'keydown', (e) ->
            if e.which == 13 and $(this).val()
                e.preventDefault()
                socket.emit 'plugins.v2mm.createTopicLabel', {value: $(this).val()}, ajaxify.refresh

        $(".topic-label-li .remove").on "click", (e) ->
            e.preventDefault()

            data = getItem $(this).closest('li').data('name')
            socket.emit 'plugins.v2mm.removeTopicLabel', data, ajaxify.refresh

        $('.topic-label-li .color-picker').each ()->
            $el = $(this)
            k = $(this).data('name')
            colorpicker.enable $el, (hsb, hex)->
                v = $el.val()
                console.log "picker color: "+hex
                cssName = if k == 'color' then 'color' else 'background-color'
                $el.closest('li').find('.topic-label').css(cssName, v)


        $('.topic-label-li .save-label-item').on 'click', () ->
            $el = $(this)

            data = getItem $(this).closest('li').data('name')
            data.color = $(this).closest('li').find('.color').val()
            data.bkColor = $(this).closest('li').find('.bkColor').val()

            socket.emit 'plugins.v2mm.createTopicLabel', data, ajaxify.refresh


        Settings.prepare()

    return ACP
