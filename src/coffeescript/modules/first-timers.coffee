Cookies = require "cookies-js"
$ = jQuery = require "jQuery"
Accordion = require "./accordions.coffee"
Modal = require "./modals.coffee"
Sticky = require "./sticky-menu.coffee"

class FirstTimers

    constructor: ->

        @el =
            accordionDisclaimerItem: $(".accordion-disclaimer").find ".accordion-item"
            modalHome: $(".modal-home")
            stickySideMenu: $(".sticky-side-menu")

        @cookie = Cookies.get "danone"
        
        if @cookie is undefined
            @showFirstTimerStuff()
            @setCookie()

    showFirstTimerStuff: ->
        if @el.modalHome.length isnt 0
            Modal.showModal @el.modalHome
        Sticky.toggleItem @el.stickySideMenu
        Accordion.toggleItem @el.accordionDisclaimerItem

    setCookie: ->
        Cookies.set "danone", JSON.stringify
            firstvisit: false


module.exports = new FirstTimers