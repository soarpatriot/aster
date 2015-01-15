$ = jQuery = require "jQuery"

class Timeline

    constructor: ->
        @el =
            button: $(".timeline-button")
            slides: $(".js-slide")
            taglines: $(".timeline-tagline")
            targets: $(".js-change-slide")
            timeline: $(".timeline")
            window: $(window)

        @addEventListeners()

    addEventListeners: ->

        for target in @el.targets
            $(target).on "click", (e) =>
                e.preventDefault()
                @el.targets.removeClass "active"
                $(e.target).addClass "active"
                if @el.window.outerWidth() < 1280
                    @moveButton $(e.target).data "left-medium"
                else
                    @moveButton $(e.target).data "left"
                @activateSlide $(e.target).data "slide"
                @activateTagline $(e.target).data "slide"
                @changeButton $(e.target).data "slide"

    moveButton: (left) ->
        @el.button.css "left", left + "%"

    changeButton: (slide) ->
        @removeAllButtonClasses()
        @el.button.toggleClass slide

    removeAllButtonClasses: ->
        @el.button.removeClass "neutral"
        @el.button.removeClass "pregnancy1"
        @el.button.removeClass "pregnancy2"
        @el.button.removeClass "pregnancy3"
        @el.button.removeClass "baby"
        @el.button.removeClass "toddler1"
        @el.button.removeClass "toddler2"

    activateSlide: (slide) ->
        @hideAllSlides()
        $(".section-home-slider-" + slide).addClass "show"

    hideAllSlides: ->
        for slide in @el.slides
            $(slide).removeClass "show"

    activateTagline: (tagline) ->
        @hideAllTaglines()
        $(".timeline-tagline-" + tagline).addClass "show"

    hideAllTaglines: ->
        for tagline in @el.taglines
            $(tagline).removeClass "show"

module.exports = new Timeline