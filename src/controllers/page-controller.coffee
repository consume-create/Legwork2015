###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Home Slides
HomeSlideModel = require '../models/slides/home-slide-model'
HomeSlideController = require './slides/home-slide-controller'

# About Slides
AboutSlideModel = require '../models/slides/about-slide-model'
AboutSlideController = require './slides/about-slide-controller'
AboutProcessSlideModel = require '../models/slides/about-process-slide-model'
AboutProcessSlideController = require './slides/about-process-slide-controller'
AboutVideoSlideModel = require '../models/slides/about-video-slide-model'
AboutVideoSlideController = require './slides/about-video-slide-controller'

# Work Slides
WorkSlideModel = require '../models/slides/work-slide-model'
WorkSlideController = require './slides/work-slide-controller'
FeaturedWorkSlideModel = require '../models/slides/featured-work-slide-model'
FeaturedWorkSlideController = require './slides/featured-work-slide-controller'
AppendixedWorkSlideModel = require '../models/slides/appendixed-work-slide-model'
AppendixedWorkSlideController = require './slides/appendixed-work-slide-controller'

class PageController

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
    @slide_m = []
    @slide_c = []

    @build()

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    @model.setV($(JST['page-view']({'id': @model.getId(), 'slides': @model.getSlideData()})))
    @model.getE().append(@model.getV())

    # Loop and create page slides

    # NOTE:
    # To add a new slide type, you must:
    # 1. Define a const slide type in ./env
    # 2. Add a data file to ./data/* where you would like to use the slide
    # 3. Add the slide model, view and controller (extend the base model and controller classes)
    # 4. Require the model and controller in the page controller and add a condition to the build method

    for id, slide of @model.getSlideData()
      $el = $('#' + @model.getId() + '-' + id)

      switch slide.slide_type
        when LW.slide_types.HOME
          @slide_m[id] = new HomeSlideModel({
            '$el': $el,
            'rgb': slide.rgb,
          })
          @slide_c[id] = new HomeSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.ABOUT
          @slide_m[id] = new AboutSlideModel({
            '$el': $el,
            'rgb': slide.rgb,
            'title': slide.title,
            'instructions': slide.instructions
          })
          @slide_c[id] = new AboutSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.ABOUT_PROCESS
          @slide_m[id] = new AboutProcessSlideModel({
            '$el': $el,
            'rgb': slide.rgb,
            'id': slide.id,
            'title': slide.title,
            'picture_src': slide.picture_src,
            'copy': slide.copy,
            'lists': slide.lists
          })
          @slide_c[id] = new AboutProcessSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.ABOUT_VIDEO
          @slide_m[id] = new AboutVideoSlideModel({
            '$el': $el,
            'rgb': slide.rgb,
            'poster_src': slide.poster_src
          })
          @slide_c[id] = new AboutVideoSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.WORK
          @slide_m[id] = new WorkSlideModel({
            '$el': $el,
            'rgb': slide.rgb,
            'title': slide.title,
            'instructions': slide.instructions
          })
          @slide_c[id] = new WorkSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.FEATURED_WORK
          @slide_m[id] = new FeaturedWorkSlideModel({
            '$el': $el,
            'rgb': slide.rgb,
            'title': slide.title,
            'callouts': slide.callouts,
            'vimeo_id': slide.vimeo_id,
            'launch_url': slide.launch_url,
            'tagline': slide.tagline,
            'picture_src': slide.picture_src,
            'clients': slide.clients,
            'mediums': slide.mediums,
            'bg_src': slide.details.bg_src,
            'poster_src': slide.details.poster_src,
            'poster_cta': slide.details.poster_cta,
            'detail_vimeo_id': slide.details.detail_vimeo_id,
            'descr_title': slide.details.descr_title,
            'descr_text': slide.details.descr_text,
            'services': slide.details.services
          })
          @slide_c[id] = new FeaturedWorkSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.APPENDIXED_WORK
          @slide_m[id] = new AppendixedWorkSlideModel({
            '$el': $el,
            'rgb': slide.rgb,
            'projects': slide.projects
          })
          @slide_c[id] = new AppendixedWorkSlideController({
            'model': @slide_m[id]
          })
        else
          throw 'ERROR: slide type does not exist'

    # Cache selectors
    @$mask_wrapper = $('.mask-wrapper', @model.getV())
    @$slides_wrapper = $('.slides-wrapper', @model.getV())
    @$nav = $('.page-nav-zone', @model.getV())
    @$filter_zone = $('.filter-zone', @model.getV())
    @$filter_btn = $('.filter-btn', @model.getV())
    @$filter_item = $('.filter-item', @model.getV())
    @$filter_bg = $('.filter-bg', @model.getV())
    @$page_btns = $('.page-nav li a', @model.getV())
    @$menu_btn = $('.menu-btn', @model.getV())
    @$about_btn = $('.about', @model.getV())

    # Details selectors
    @$detail_slide = $('.detail-slide', @model.getV())
    @$active_detail = null

    @total_page_btns = @$page_btns.length
    @active_c = null
    @active_index = 0
    @old_index = 0
    
    # Mousewheel vars
    @threshold_hit = false

    # Draggable vars
    @resistance = 1
    @dragging = false
    @drag_time = 666
    @start_time = 0
    @start_y = 0
    @current_y = 0
    @range = 30
    @current_range = 0
    @now = 0
    @drag_obj = {}

    @mousedown = if Modernizr.touch then "touchstart" else "mousedown"
    @mousemove = if Modernizr.touch then "touchmove" else "mousemove"
    @mouseup = if Modernizr.touch then "touchend" else "mouseup"

  ###
  *------------------------------------------*
  | resize:void (-)
  |
  | Resize.
  *----------------------------------------###
  resize: ->
    @active_c.resize() if @active_c.resize?

  ###
  *------------------------------------------*
  | goToSlide:void (=)
  |
  | route:object - current route
  |
  | Go to slide.
  *----------------------------------------###
  goToSlide: (route) =>
    slide = route.key.split(':')[1] || _.keys(@model.getSlideData())[0]

    @$page_btns.removeClass('active').filter('[data-id="' + slide + '"]').addClass('active')
    @active_index = $('.page-nav li a.active', @model.getV()).parent().index()
    direction = if @active_index >= @old_index then 'bottom' else 'top'

    if @active_c isnt null
      @active_c.transitionOut(direction, =>
        s.suspend() for id, s of @slide_c
        @slide_c[slide].activate()
        @slide_c[slide].transitionIn(direction)
        @active_c = @slide_c[slide]
      )
    else
      s.suspend() for id, s of @slide_c
      @slide_c[slide].activate()
      @slide_c[slide].transitionIn(direction)
      @active_c = @slide_c[slide]
    
    @setBackgroundColor(@slide_c[slide].model._rgb)
    @old_index = @active_index

    if LW.virgin is false
      @hidePageNav()

    @hideDetails()

  ###
  *------------------------------------------*
  | setBackgroundColor:void (-)
  |
  | Set background color.
  *----------------------------------------###
  setBackgroundColor: (rgb) ->
    if @dragging is true
      @$mask_wrapper.addClass('no-bg-trans')
    else
      @$mask_wrapper.removeClass('no-bg-trans')

    @$mask_wrapper[0].offsetHeight
    @$mask_wrapper.css('background-color': "rgb(#{rgb})")

  ###
  *------------------------------------------*
  | onKeyup:void (-)
  |
  | Keyup.
  *----------------------------------------###
  onKeyup: (e) =>
    kc = e.keyCode

    if kc is 38
      e.preventDefault()
      @previous()

    if kc is 40
      e.preventDefault()
      @next()

  ###
  *------------------------------------------*
  | onMousewheel:void (=)
  |
  | Rip'it with the mousewheel.
  *----------------------------------------###
  onMousewheel: (e) =>
    e.preventDefault()
    delta = e.originalEvent.wheelDelta / 120 or -e.originalEvent.detail / 3
    
    if Math.abs(delta) >= 1.5 and @threshold_hit is false
      @threshold_hit = true
      if delta > 0
        @previous()
      else
        @next()

      setTimeout =>
        @threshold_hit = false
      , 666

  ###
  *------------------------------------------*
  | onMouseDown:void (=)
  |
  | Mouse down.
  *----------------------------------------###
  onMouseDown: (e) =>
    @dragging = true

    @start_time = (new Date()).getTime()
    @start_y = if Modernizr.touch then e.originalEvent.pageY else e.pageY

    LW.$doc.off(@mouseup)
      .one(@mouseup, @onMouseUp)

  ###
  *------------------------------------------*
  | onMouseMove:void (=)
  |
  | Mouse move.
  *----------------------------------------###
  onMouseMove: (e) =>
    if @dragging is true
      e.preventDefault()

      @current_y = if Modernizr.touch then e.originalEvent.pageY else e.pageY
      @direction_y = @current_y - @start_y
      @current_range = if @start_y is 0 then 0 else Math.abs(@direction_y)
      @now = (new Date()).getTime()

      if @direction_y >= 0 and @active_index is 0 or @direction_y <= 0 and @active_index is (@total_page_btns - 1)
        obj = {}
        obj[LW.utils.transform] = LW.utils.translate(0,"#{(@direction_y * 0.25) + 'px'}")
        @$slides_wrapper.css(obj)
      else
        c1 = @$page_btns.eq(@active_index).data('rgb')
        c2 = if @direction_y < 0 then @$page_btns.eq(@active_index + 1).data('rgb') else @$page_btns.eq(@active_index - 1).data('rgb')
        
        p = Math.min(Math.max((@current_range / 200), 0), 1)
        r = Math.round(((c2[0] - c1[0]) * p) + c1[0])
        g = Math.round(((c2[1] - c1[1]) * p) + c1[1])
        b = Math.round(((c2[2] - c1[2]) * p) + c1[2])
        rgb = [r, g, b]

        @setBackgroundColor(rgb)

      @$slides_wrapper.addClass('dragging')
      return false

  ###
  *------------------------------------------*
  | onMouseUp:void (=)
  |
  | Mouse Up.
  *----------------------------------------###
  onMouseUp: =>
    obj = {}
    obj[LW.utils.transform] = LW.utils.translate(0,0 + 'px')
    @$slides_wrapper.css(obj)
    @dragging = false

    if @$slides_wrapper.hasClass('dragging')
      @$slides_wrapper.removeClass('dragging')

      if @now - @start_time < @drag_time and @current_range > @range or @current_range > (@$slides_wrapper.height() / 2)
        if @current_y < @start_y
          @next()
        if @current_y > @start_y
          @previous()
      else
        @setBackgroundColor(@$page_btns.eq(@active_index).data('rgb'))

      return false

  ###
  *------------------------------------------*
  | previous:void (-)
  |
  | Previous slide, if there is one.
  *----------------------------------------###
  previous: ->
    if @active_index > 0
      href = @$page_btns.eq(@active_index - 1).attr('href')
      History.pushState(null, null, href)

  ###
  *------------------------------------------*
  | next:void (-)
  |
  | Next slide, if there is one.
  *----------------------------------------###
  next: ->
    if @active_index < (@total_page_btns - 1)
      href = @$page_btns.eq(@active_index + 1).attr('href')
      History.pushState(null, null, href)

  ###
  *------------------------------------------*
  | onMouseEnterNav:void (=)
  |
  | Mouse enter nav.
  *----------------------------------------###
  onMouseEnterNav: =>
    if @$menu_btn.is(':hidden')
      @showPageNav()

  ###
  *------------------------------------------*
  | onMouseLeaveNav:void (=)
  |
  | Mouse leave nav.
  *----------------------------------------###
  onMouseLeaveNav: =>
    if @$menu_btn.is(':hidden')
      @hidePageNav()

  ###
  *------------------------------------------*
  | hidePageNav:void (=)
  |
  | Hide page nav.
  *----------------------------------------###
  hidePageNav: =>
    @$nav.removeClass('show')
    @$menu_btn.removeClass('close')

    if @$filter_zone.length > 0
      @hideFilterList()

  ###
  *------------------------------------------*
  | showPageNav:void (=)
  |
  | Show page nav.
  *----------------------------------------###
  showPageNav: =>
    @$nav.addClass('show')
    @$menu_btn.addClass('close')

  ###
  *------------------------------------------*
  | onClickFilterBtn:void (=)
  |
  | Click filter btn.
  *----------------------------------------###
  onClickFilterBtn: =>
    if @$filter_zone.hasClass('drop-down')
      @hideFilterList()
    else
      @showFilterList()

  ###
  *------------------------------------------*
  | onClickFilterBg:void (=)
  |
  | Click filter bg.
  *----------------------------------------###
  onClickFilterBg: =>
    @hideFilterList()

  ###
  *------------------------------------------*
  | hideFilterList:void (=)
  |
  | Hide filter list.
  *----------------------------------------###
  hideFilterList: =>
    @$filter_zone.removeClass('drop-down')

  ###
  *------------------------------------------*
  | showFilterList:void (=)
  |
  | Show filter list.
  *----------------------------------------###
  showFilterList: =>
    @$filter_zone.addClass('drop-down')

  ###
  *------------------------------------------*
  | onClickMenuBtn:void (=)
  |
  | Click menu btn.
  *----------------------------------------###
  onClickMenuBtn: =>
    if @$menu_btn.hasClass('close')
      @hidePageNav()
    else
      @showPageNav()

  ###
  *------------------------------------------*
  | hideDetails:void (=)
  |
  | Hide details.
  *----------------------------------------###
  hideDetails: =>
    if @$mask_wrapper.hasClass('unmask')
      @$mask_wrapper.removeClass('unmask')

  ###
  *------------------------------------------*
  | showDetails:void (=)
  |
  | Show details.
  *----------------------------------------###
  showDetails: =>
    id = $('.slide', @model.getV()).eq(@active_index).attr('id')
    id = id.replace('work', 'detail')
    
    @$detail_slide.removeClass('active').filter("[data-detail='#{id}']").addClass('active')
    @$active_detail = @$detail_slide.filter("[data-detail='#{id}']")

    @$mask_wrapper[0].offsetHeight # Reflow like a a defer
    @$mask_wrapper.addClass('unmask')

    LW.close_project = true
    LW.instance.header_c.navTransition()

    @loadDetailTransition()

  ###
  *------------------------------------------*
  | loadDetailTransition:void (=)
  |
  | Load detail and transition black box.
  *----------------------------------------###
  loadDetailTransition: =>
    $loader = $('.detail-loader', @$active_detail)
    $black_box = $('.black-box', @$active_detail)
    $bg = $('.bg', @$active_detail)
    src = $bg.attr('data-src')

    $black_box.removeClass('slide-up')
    @$active_detail.find('.content').scrollTop(0)
    @$active_detail[0].offsetHeight # Reflow like a a defer

    if $loader.length > 0
      $current = $('<img />').attr
        'src': src
      .one 'load', (e) =>
        $bg.attr('style': "background-image: url(#{src})")
        $loader
          .addClass('loaded')
          .off()
          .one(LW.utils.transition_end, =>
            $black_box.addClass('slide-up')
            $loader.remove()
          )

      if $current[0].complete is true
        $current.trigger('load')

      return $current[0]
    else
      $black_box.addClass('slide-up')

  ###
  *------------------------------------------*
  | reset:void (-)
  |
  | Reset.
  *----------------------------------------###
  reset: ->
    @dragging = false
    @start_time = 0
    @start_y = 0
    @current_y = 0
    @current_range = 0
    @now = 0

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @model.getE().show()
    @reset()

    # If there are page_btns,
    # we have events to listen to...
    if @total_page_btns > 1
      LW.$doc
        .off("keyup.#{@model._id}")
        .on("keyup.#{@model._id}", @onKeyup)

      @$slides_wrapper
        .off("mousewheel DOMMouseScroll #{@mousedown} #{@mousemove} contextmenu")
        .on("mousewheel DOMMouseScroll", @onMousewheel)
        .on(@mousedown, @onMouseDown)
        .on(@mousemove, @onMouseMove)
        .on('contextmenu', =>
          return false
        )

      @$nav
        .off('mouseenter')
        .on('mouseenter', @onMouseEnterNav)

      @$filter_btn
        .off('click')
        .on('click', @onClickFilterBtn)

      @$filter_bg
        .off('click')
        .on('click', @onClickFilterBg)

      @$menu_btn
        .off('click')
        .on('click', @onClickMenuBtn)

      @$about_btn
        .off('click')
        .on('click', @showDetails)

      # Check if cookie is set
      if $.cookie('cookie_monster') is 'stuffed'
        LW.virgin = false
      else
        $.cookie('cookie_monster', 'stuffed', {expires: 13, path: '/'})

      # Now check if it's our first time and show or hide the nav
      if LW.virgin is true
        @showPageNav()

        setTimeout =>
          LW.virgin = false
          @$nav
            .off('mouseleave')
            .on('mouseleave', @onMouseLeaveNav)
          
          if @$nav.is(':hover') is false
            @hidePageNav()
        , 2000
      else
        @$nav
          .off('mouseleave')
          .on('mouseleave', @onMouseLeaveNav)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    @model.getE().hide()
    s.suspend() for id, s of @slide_c
    @active_c = null

    # If there were page_btns,
    # we have events to listen to turn off...
    if @total_page_btns > 1
      LW.$doc.off("keyup.#{@model._id}")
      @$slides_wrapper.off("mousewheel DOMMouseScroll #{@mousedown} #{@mousemove} contextmenu")
      @$nav.off('mouseenter mouseleave')
      @$filter_btn.off('click')
      @$filter_bg.off('click')
      @$menu_btn.off('click')
      @$about_btn.off('click')
      @hideDetails()

module.exports = PageController