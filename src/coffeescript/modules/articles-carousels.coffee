$ = jQuery = require "jQuery"
Modernizr = require "modernizr"

(($, window, undefined_) ->
    "use strict"

    # global
    Modernizr = window.Modernizr
    $.CBPFWSlider = (options, element) ->
        @$el = $(element)
        @_init options
        return

    # the options
    $.CBPFWSlider.defaults =

        # default transition speed (ms)
        speed: 500

        # default transition easing
        easing: "ease"

    $.CBPFWSlider:: =
        _init: (options) ->

            # options
            @options = $.extend(true, {}, $.CBPFWSlider.defaults, options)

            # cache some elements and initialize some variables
            @_config()

            # initialize/bind the events
            @_initEvents()
            return

        _config: ->

            # the list of items
            @$list = @$el.children("ul")

            # the items (li elements)
            @$items = @$list.children("li")

            # total number of items
            @itemsCount = @$items.length

            # support for CSS Transitions & transforms
            @support = Modernizr.csstransitions and Modernizr.csstransforms
            @support3d = Modernizr.csstransforms3d

            # transition end event name and transform name
            transProperties =
                WebkitTransition:
                    transitionEndEvent: "webkitTransitionEnd"
                    tranformName: "-webkit-transform"

                MozTransition:
                    transitionEndEvent: "transitionend"
                    tranformName: "-moz-transform"

                OTransition:
                    transitionEndEvent: "oTransitionEnd"
                    tranformName: "-o-transform"

                msTransition:
                    transitionEndEvent: "MSTransitionEnd"
                    tranformName: "-ms-transform"

                transition:
                    transitionEndEvent: "transitionend"
                    tranformName: "transform"

            if @support
                @transEndEventName = transProperties[Modernizr.prefixed("transition")]
                .transitionEndEvent + ".cbpFWSlider"
                @transformName = transProperties[Modernizr.prefixed("transition")].tranformName

            # current and old item´s index
            @current = 0
            @old = 0

            # check if the list is currently moving
            @isAnimating = false

            # the list (ul) will have a width of 100% x itemsCount
            @$list.css "width", 100 * @itemsCount + "%"

            # apply the transition
            @$list.css "transition", @transformName + " " + @options.speed +
             "ms " + @options.easing  if @support

            # each item will have a width of 100 / itemsCount
            @$items.css "width", 100 / @itemsCount + "%"

            # add navigation arrows and the navigation dots if there is more than 1 item
            if @itemsCount > 1

                navigation = $("<div class='article-navigation'></div>")

                # add navigation arrows (the previous arrow is not shown initially):
                @$navPrev = $("<span class=\"button" +
                    " article-navigation-button previous-article\"><svg viewBox=\"0 0 24 24\"" +
                    " class=\"icon icon-keyboard-arrow-left\"><use xmlns:xlink=\"http://" +
                        "www.w3.org/1999/xlink\" xlink:href=\"#icon-keyboard-arrow-left\">" +
                        "</use></svg></span>").hide()
                @$navNext = $("<span class=\"button " +
                    "article-navigation-button next-article\"><svg viewBox=\"0 0 24 24\" " +
                    "class=\"icon icon-keyboard-arrow-right\"><use xmlns:xlink=\"http://" +
                        "www.w3.org/1999/xlink\" xlink:href=\"#icon-keyboard-arrow-right\">" +
                        "</use></svg></span>")
                # $("<nav/>").append(@$navPrev, @$navNext).appendTo @$el

                if @$el.hasClass "articles-carousel-small"
                    navigation.addClass "small"
                    # @$navPrev.addClass "small"
                    # @$navNext.addClass "small"

                if @$el.hasClass "articles-carousel-medium"
                    navigation.addClass "medium"
                    # @$navPrev.addClass "medium"
                    # @$navNext.addClass "medium"

                if @$el.hasClass "articles-carousel-large"
                    navigation.addClass "large"
                    # @$navPrev.addClass "large"
                    # @$navNext.addClass "large"

                navigation.append @$navPrev
                navigation.append @$navNext

                @$el.parent().append navigation

                # @$el.parent().append @$navPrev
                # @$el.parent().append @$navNext

            return

        _initEvents: ->
            self = this
            if @itemsCount > 1
                @$navPrev.on "click.cbpFWSlider", $.proxy(@_navigate, this, "previous")
                @$navNext.on "click.cbpFWSlider", $.proxy(@_navigate, this, "next")

            return

        _navigate: (direction) ->

            # do nothing if the list is currently moving
            return false if @isAnimating
            @isAnimating = true

            # update old and current values
            @old = @current
            if direction is "next" and @current < @itemsCount - 1
                ++@current
            else --@current  if direction is "previous" and @current > 0

            # slide
            @_slide()
            return

        _slide: ->

            # check which navigation arrows should be shown
            @_toggleNavControls()

            # translate value
            translateVal = -1 * @current * 100 / @itemsCount
            if @support
                @$list.css "transform", (if @support3d then "translate3d(" + translateVal +
                 "%,0,0)" else "translate(" + translateVal + "%)")
            else
                @$list.css "margin-left", -1 * @current * 100 + "%"
            transitionendfn = $.proxy(->
                @isAnimating = false
                return
            , this)

            # if @support
            #     @$list.on @transEndEventName, $.proxy(transitionendfn, this)
            # else
            #     transitionendfn.call()

            transitionendfn.call()

            return

        _toggleNavControls: ->

            # if the current item is the first one in the list, the left arrow is not shown
            # if the current item is the last one in the list, the right arrow is not shown
            switch @current
                when 0
                    @$navNext.show()
                    @$navPrev.hide()
                when @itemsCount - 1
                    @$navNext.hide()
                    @$navPrev.show()
                else
                    @$navNext.show()
                    @$navPrev.show()

            return

        _jump: (position) ->

            # do nothing if clicking on the current dot, or if the list is currently moving
            return false  if position is @current or @isAnimating
            @isAnimating = true

            # update old and current values
            @old = @current
            @current = position

            # slide
            @_slide()
            return

        destroy: ->
            @$list.css "width", "auto"
            @$list.css "transition", "none"  if @support
            @$items.css "width", "auto"
            return

    logError = (message) ->
        window.console.error message  if window.console
        return

    $.fn.cbpFWSlider = (options) ->
        if typeof options is "string"
            args = Array::slice.call(arguments, 1)
            @each ->
                instance = $.data(this, "cbpFWSlider")
                unless instance
                    logError "cannot call methods on cbpFWSlider prior to initialization; " +
                     "attempted to call method '" + options + "'"
                    return
                if not $.isFunction(instance[options]) or options.charAt(0) is "_"
                    logError "no such method '" + options + "' for cbpFWSlider instance"
                    return
                instance[options].apply instance, args
                return

        else
            @each ->
                instance = $.data(this, "cbpFWSlider")
                if instance
                    instance._init()
                else
                    instance = $.data(this, "cbpFWSlider", new $.CBPFWSlider(options, this))
                return

        this

    return
) jQuery, window

$(".articles-carousel").cbpFWSlider()