$ = jQuery = require "jQuery"

class Search

    constructor: ->
        @el =
            searchInputs: $(".form-search-query")
            suggestions: $(".suggestions")

        @addEventListeners()

    addEventListeners: ->

        for input in @el.searchInputs

            suggestions = $(input).next()

            $(input).on "focus", =>
                @showSuggestions suggestions

            $(input).on "blur", =>
                @hideSuggestions()

    showSuggestions: (box) ->
        # fetch search results
        box.addClass "show"

    hideSuggestions: ->
        @el.suggestions.removeClass "show"

module.exports = new Search