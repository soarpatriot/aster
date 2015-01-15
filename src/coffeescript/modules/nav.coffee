$ = jQuery = require "jQuery"

class Nav

	constructor: ->

		@el =
			taggleBtn: $(".navbar-toggle")
			nav: $("#accordion")
		@addEventListeners()

	addEventListeners: ->

		@el.taggleBtn.on "click", =>
			@el.taggleBtn.toggleClass("switch-style")
			@toggleNav()
		
	toggleNav: ->
		@el.nav.toggleClass "medium-hidden"
		@el.nav.toggleClass "small-hidden"
		
module.exports = new Nav