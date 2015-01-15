$ = jQuery = require "jQuery"

class Carousel

    constructor: (el, time) ->

        @carousel = el
        @carouselItems = $(@carousel).find ".carousel-item"
        @numberOfItems = @carouselItems.length

        @setupPagination()

        @currentItem = 0

        @goto(@currentItem)

        @time = time || 5000
        @timer = undefined

        if $(@carousel).hasClass "js-carousel--automatic"
            @startTimer(@time, 0)

        # options =
        #     dragLockToAxis: true
        #     dragBlockHorizontal: true

    setupPagination: ->

        pagination = "<ul class='pagination' data-carousel=" +
         @carousel.getAttribute("id") + ">"
        for item, index in @carouselItems
            pagination += "<li class='pagination-item'><a href='javascript:void(0);'" +
                " title=''></a></li>"
        pagination += "</ul>"
        @carousel.insertAdjacentHTML "beforeBegin", pagination

        @pagination = (document.querySelectorAll "[data-carousel='" +
            @carousel.getAttribute("id") + "']")[0]
        @paginationItems = @pagination.childNodes

        addEvent = (item, index) =>
            item.childNodes[0].addEventListener "click", (e) =>
                e.preventDefault()
                @currentItem = index
                @goto(@currentItem)

                if $(@carousel).hasClass "js-carousel--automatic"
                    @stopTimer()
                    @startTimer(@time, index)

        for item, index in @paginationItems
            addEvent(item, index)

    goto: (index) ->
        @clearAll()
        $(@paginationItems[index]).addClass "current"
        $(@carouselItems[index]).addClass "show"

        @carousel.style.height = @carouselItems[index].scrollHeight + "px"

    clearAll: ->

        for item in @paginationItems
            if $(item).hasClass "current"
                $(item).removeClass "current"

        for item in @carouselItems
            if $(item).hasClass "show"
                $(item).removeClass "show"

    startTimer: (time, index) ->

        @timer = setInterval =>

            @next()

        , time

    stopTimer: ->

        clearInterval @timer

    prev: ->
        if @currentItem is 0
            @currentItem = @carouselItems.length
        else
            @currentItem--

        @goto(@currentItem)

    next: ->
        if @currentItem is @numberOfItems - 1
            @currentItem = 0
        else
            @currentItem++

        @goto(@currentItem)

module.exports = Carousel

carousels = $(".carousel")
for carousel in carousels
    new Carousel carousel, 5000