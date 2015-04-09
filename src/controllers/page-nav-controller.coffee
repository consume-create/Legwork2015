###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class PageNavController

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | init:object - init object
  |
  | Construct.
  *----------------------------------------###
  constructor: (init) ->
    @model = init.model
    @build()

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    @model.setV($(JST['page-nav-view']({
      'links': @model.getLinks()
    })))
    @model.getE().append(@model.getV())

    @$page_btns = $('.page-nav li a', @model.getV())

  ###
  *------------------------------------------*
  | preview:void (-)
  |
  | Preview.
  *----------------------------------------###
  preview: ->
    if LW.utils.is_mobile.any() is false
      @showPageNav() 

      setTimeout =>
        if @model.getE().is(':hover') is false
          @hidePageNav()
      , 2000

  ###
  *------------------------------------------*
  | onMouseEnterNav:void (=)
  |
  | Mouse enter nav.
  *----------------------------------------###
  onMouseEnterNav: =>
    @showPageNav()

  ###
  *------------------------------------------*
  | onMouseLeaveNav:void (=)
  |
  | Mouse leave nav.
  *----------------------------------------###
  onMouseLeaveNav: =>
    @hidePageNav()

  ###
  *------------------------------------------*
  | hidePageNav:void (=)
  |
  | Hide page nav.
  *----------------------------------------###
  hidePageNav: =>
    @model.getE().removeClass('show')

  ###
  *------------------------------------------*
  | showPageNav:void (=)
  |
  | Show page nav.
  *----------------------------------------###
  showPageNav: =>
    @model.getE().addClass('show')

  ###
  *------------------------------------------*
  | previous:void (-)
  |
  | Previous slide, if there is one.
  *----------------------------------------###
  previous: (active_index) ->
    href = @$page_btns.eq(active_index - 1).attr('href')
    History.pushState(null, null, href)

  ###
  *------------------------------------------*
  | next:void (-)
  |
  | Next slide, if there is one.
  *----------------------------------------###
  next: (active_index) ->
    href = @$page_btns.eq(active_index + 1).attr('href')
    History.pushState(null, null, href)

  ###
  *------------------------------------------*
  | updatePageNav:void (-)
  |
  | Update page nav based on active slide.
  *----------------------------------------###
  updatePageNav: (slide) ->
    @$page_btns.removeClass('active').filter('[data-id="' + slide + '"]').addClass('active')

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    if LW.utils.is_mobile.any() is false
      @model.getE()
        .off('mouseenter')
        .on('mouseenter', @onMouseEnterNav)

      @model.getE()
        .off('mouseleave')
        .on('mouseleave', @onMouseLeaveNav)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    if LW.utils.is_mobile.any() is false
      @model.getE().off('mouseenter mouseleave')

module.exports = PageNavController