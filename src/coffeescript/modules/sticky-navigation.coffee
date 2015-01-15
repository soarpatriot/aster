$ = jQuery = require "jQuery"

class StickyNavigation

    constructor: ->

        @el =
            menu: $(".navbar-dropdown-section")
            window: $(window)

        @scrolled = false

        @addEventListeners()

    addEventListeners: ->

        @el.window.on "scroll", =>
            @scrolled = true

        setInterval =>
            if @scrolled
                @checkScrollPosition()
                @scrolled = false
        , 100

    checkScrollPosition: ->

        if @el.window.scrollTop() > 115
            if !@el.menu.hasClass "stuck"
                @el.menu.addClass "stuck"
        else
            if @el.menu.hasClass "stuck"
                @el.menu.removeClass "stuck"


module.exports = new StickyNavigation