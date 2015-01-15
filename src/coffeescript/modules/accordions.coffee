$ = jQuery = require "jQuery"

class Accordions

    constructor: ->

        @el =
            accordions: $(".accordion")

        @setupAccordions()

    setupAccordions: ->

        for accordion in @el.accordions

            @setupAccordion accordion

    setupAccordion: (accordion) ->

        itemContents = $(accordion).find ".accordion-item-content"

        for item in itemContents
            height = $(item).height()
            $(item).attr "data-height", height
            if not $(item).hasClass "open"
                $(item).height 0
            else
                $(item).height height

        buttons = $(accordion).find ".accordion-item-trigger"

        for button in buttons
            item = $(button).parent()
            @addEventListener item, button, accordion

    addEventListener: (item, button, accordion) ->

        $(button).on "click", (e) =>
            e.preventDefault()
            if item.hasClass "open"
                @closeItem item
            else
                @closeAccordionItems accordion
                @openItem item
            # @toggleItem item

    closeAccordionItems: (accordion) ->

        items = $(accordion).find ".accordion-item"

        for item in items
            @closeItem $(item)

    closeItem: (item) ->
        contents = item.find(".accordion-item-content")[0]
        $(contents).height 0

        item.removeClass "open"

    openItem: (item) ->
        contents = item.find(".accordion-item-content")[0]
        $(contents).height $(contents).data "height"

        item.addClass "open"

    toggleItem: (item) ->
        contents = $(item).find(".accordion-item-content")[0]

        if $(item).hasClass "open"
            $(contents).height 0
        else
            $(contents).height $(contents).data "height"

        $(item).toggleClass "open"

module.exports = new Accordions