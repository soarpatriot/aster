$ = jQuery = require "jQuery"

class Modals

    constructor: ->

        @el =
            body: $("body")

    showModal: (modal) ->
        # aria role!!
        @el.body.addClass "modal-open"
        $(modal).prepend "<div class='modal-backdrop'>"
        backdrop = $(modal).find ".modal-backdrop"
        dialog = $(modal).find ".modal-dialog"
        $(modal).css "display", "block"

        setTimeout ->
            # backdrop.height @el.body.outerHeight() + 60
            $(modal).addClass "show"
        , 2000

        $(modal).attr "aria-hidden", "false"

        button = $(modal).find ".modal-close-button"
        button.on "click", (e) =>
            e.preventDefault()
            @closeModal modal

        backdrop.on "click", =>
            @closeModal modal

    closeModal: (modal) ->
        $(modal).removeClass "show"
        setTimeout ->
            $(modal).css "display", "none"
        , 300
        @el.body.removeClass "modal-open"
        $(modal).attr "aria-hidden", "true"
        $(modal).find(".modal-backdrop").remove()

module.exports = new Modals