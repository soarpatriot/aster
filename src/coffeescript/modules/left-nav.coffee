$ = jQuery = require "jQuery"

class LeftNav

	constructor: ->

		@el =
			taggleBtn: $(".left-navbar-toggle")
			nav: $(".dropdown-menu")
		@addEventListeners()

	addEventListeners: ->

		@el.taggleBtn.on "click", =>
			@el.taggleBtn.toggleClass("toggled-style")
			@el.nav.parent().toggleClass("open")
			


module.exports = new LeftNav