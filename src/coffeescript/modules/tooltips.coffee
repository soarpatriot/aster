$ = jQuery = require "jQuery"

class Tooltip

	constructor: ->
		@el =
			triggers: $(".tooltip-trigger")

		@setupTooltips()

	setupTooltips: ->

		for trigger in @el.triggers

			@appendTooltip $(trigger)

	appendTooltip: (trigger) ->
		data =
			content: trigger.data "content"
			title: trigger.data "title"

		tooltip = trigger.append @renderTemplate data.content, data.title

		@addEventListener trigger

	renderTemplate: (content, title) ->

		temp = $(
			"<div class='tooltip'>" +
				 "<div class='tooltip-content'>" +
				 	 "<div class='tooltip-content-body'>" + content + "</div>" +
				 	 "<div class='tooltip-content-title'>" + title + "</div>" +
				 "</div>" +
			"</div>"
		)

	addEventListener: (trigger) ->

		tooltip = trigger.find ".tooltip"

		trigger.on "mouseenter", ->
			tooltip.addClass "show"

		trigger.on "mouseleave", ->
			tooltip.removeClass "show"

		trigger.on "click", (e) ->
			e.preventDefault()
			tooltip.toggleClass "show"

module.exports = new Tooltip