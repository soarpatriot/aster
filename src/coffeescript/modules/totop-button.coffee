$ = jQuery = require "jQuery"

class TotopButton

    constructor: ->

        @el =
            articleFooter: $(".section-article-footer")
            articleNavigation: $("nav.article-navigation")
            body: $("body")
            button: $(".button-totop")
            window: $(window)

        @scrolled = false

        if @el.button.length isnt 0
            @addEventListeners()

    addEventListeners: ->

        @el.button.on "click", (e) ->
            e.preventDefault()
            $("html, body").animate
                scrollTop: 0

        $(window).scroll =>
            @scrolled = true

        setInterval =>
            if @scrolled
                @checkButton()
                if @el.articleNavigation.length isnt 0
                    @checkNavigation()
                @scrolled = false
        , 500

    checkButton: ->

        if @el.window.scrollTop() > 300
            @showButton()
        else
            @hideButton()

    checkNavigation: ->

        if @el.window.scrollTop() > 300
            # if (@el.window.scrollTop() + @el.window.height()) < (@el.body.height() * 0.75)
            if (@el.window.scrollTop() + @el.window.height()) < @el.articleFooter.offset().top
                @showNavigation()
            else
                @hideNavigation()
        else
            @hideNavigation()

    showButton: ->
        if not @el.button.hasClass "show"
            @el.button.addClass "show"

    hideButton: ->
        if @el.button.hasClass "show"
            @el.button.removeClass "show"

    showNavigation: ->
        if not @el.articleNavigation.hasClass "show"
            @el.articleNavigation.addClass "show"

    hideNavigation: ->
        if @el.articleNavigation.hasClass "show"
            @el.articleNavigation.removeClass "show"

module.exports = new TotopButton