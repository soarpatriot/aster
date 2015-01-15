$ = jQuery = require "jQuery"

class EqualHeights

	constructor: ->

		@el =
			equalHeights: $(".equal-height")

		@resized = false
		setTimeout =>
			@resizeStuff()
			@setupListeners()
		, 4000

	setupListeners: ->

		$(window).on "resize", =>
			@resized = true

		setInterval =>
			if @resized
				@resizeStuff()
				@resized = false
		, 500

	resizeStuff: ->

		if @el.equalHeights.length > 0 && window.outerWidth > 767
			@makeElementsSameHeight(@el.equalHeights)

	makeElementsSameHeight: (elements) ->

		height = 0
		for el in elements
			if $(el).height() > height
				height = $(el).height()

		for el in elements
			$(el).height height

module.exports = new EqualHeights