$ = jQuery = require "jQuery"

class Dropdowns

    constructor: ->

        @el =
            calendarButtons: $(".dropdown-toggle")
            calendarDropdowns: $(".dropdown-section-content")
            calendarDropdownSections: $(".dropdown-section")
            dropdowns: $(".navbar-button-dropdown")
            dropdownSection: $(".navbar-dropdown-section")
            links: $(".navbar-button a")

        @addEventListeners()

    addEventListeners: ->

        for link in @el.links

            $(link).on "mouseenter", (e) =>
                e.preventDefault()
                @hideAllDropdowns()
                $(e.target).parent().addClass "active"
                @showDropdown $(e.target).data "dropdown"

            $(link).on "click", (e) ->
                e.preventDefault()

        @el.dropdownSection.on "mouseleave", =>
            @hideAllDropdowns()

        for dropdown in @el.dropdowns

            $(dropdown).on "mouseleave", (e) =>
                e.preventDefault()
                @hideAllDropdowns()


        if @el.calendarButtons.length isnt 0
            for calendarButton in @el.calendarButtons
                $(calendarButton).on "click", =>
                    @toggleCalendar()

    showDropdown: (dropdown) ->
        dropdown = $(".navbar-button-dropdown--" + dropdown)
        $(dropdown).addClass "show"

    hideAllDropdowns: ->
        for link in @el.links
            $(link).parent().removeClass "active"

        for dropdown in @el.dropdowns
            $(dropdown).removeClass "show"

    showCalendar: ->
        @el.calendarDropdowns.addClass "show"

    hideCalendar: ->
        @el.calendarDropdowns.removeClass "show"

    toggleCalendar: ->
        @el.calendarDropdowns.toggleClass "show"

module.exports = new Dropdowns