$ = jQuery = require "jQuery"
collapse = require "collapse"
dropdown = require "dropdown"

module.exports = ->
	$(".collapse").collapse
		toggle: false

	$(".dropdown-toggle").dropdown()