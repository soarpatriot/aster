$ = jQuery = require "jQuery"

class Menu

    constructor: ->

        @el =
            toggleMenuButton: $(".js-toggle-menu")
            toggleSearchButton: $(".js-toggle-search")
            navbar: $(".navbar")
            inlineSearch: $(".form-search--inline")

        @addEventListeners()

    addEventListeners: ->

        $(@el.toggleMenuButton).on "click", (e) =>
            e.preventDefault()
            $(e.target).toggleClass "open"
            @toggleMenu()

        $(@el.toggleSearchButton).on "click", (e) =>
            e.preventDefault()
            @toggleSearch()

    toggleMenu: ->
        $(@el.navbar).toggleClass "show"

    toggleSearch: ->
        $(@el.inlineSearch).toggleClass "open"

        if $(@el.inlineSearch).hasClass "open"
            $(@el.inlineSearch).find(".form-search-query").focus()

module.exports = new Menu