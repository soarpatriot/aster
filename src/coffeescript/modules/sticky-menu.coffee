$ = jQuery = require "jQuery"

class Sticky

	constructor: ->
		@el =
			button: $(".sticky-button")
			sticky: $(".sticky")

		@addEventListeners()

	addEventListeners: ->

		@el.button.on "click", (e) =>
			e.preventDefault()
			@toggleItem @el.sticky

	toggleItem: (item) ->
		item.toggleClass "show"


module.exports = new Sticky