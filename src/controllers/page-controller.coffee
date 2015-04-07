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

# Work Slides
WorkSlideModel = require '../models/slides/work-slide-model'
WorkSlideController = require './slides/work-slide-controller'
FeaturedWorkSlideModel = require '../models/slides/featured-work-slide-model'
FeaturedWorkSlideController = require './slides/featured-work-slide-controller'

# Page Nav
PageNavModel = require '../models/page-nav-model'
PageNavController = require './page-nav-controller'

# Work Detail
WorkDetailModel = require '../models/slides/detail/work-detail-model'
WorkDetailController = require './slides/detail/work-detail-controller'

# Watch Video
WatchVideoModel = require '../models/watch-video-model'
WatchVideoController = require './watch-video-controller'

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
    @work_detail_m = []
    @work_detail_c = []

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

    # Build watch video
    @watch_video_m = new WatchVideoModel({
      '$el': $('.watch-video-wrapper', @model.getV())
    })
    @watch_video_c = new WatchVideoController({
      'model': @watch_video_m
    })

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
            'instructions': slide.instructions
          })
          @slide_c[id] = new HomeSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.ABOUT
          @slide_m[id] = new AboutSlideModel({
            '$el': $el,
            'title': slide.title,
            'instructions': slide.instructions
          })
          @slide_c[id] = new AboutSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.ABOUT_PROCESS
          @slide_m[id] = new AboutProcessSlideModel({
            '$el': $el,
            'id': slide.id,
            'title': slide.title,
            'picture_src': slide.picture_src,
            'copy': slide.copy,
            'lists': slide.lists
          })
          @slide_c[id] = new AboutProcessSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.WORK
          @slide_m[id] = new WorkSlideModel({
            '$el': $el,
            'id': slide.id,
            'title': slide.title,
            'reel_video_id': slide.reel_video_id,
            'instructions': slide.instructions,
            'watch_url': '/' + @model.getId() + '/reel'
          })
          @slide_c[id] = new WorkSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.FEATURED_WORK
          @slide_m[id] = new FeaturedWorkSlideModel({
            '$el': $el,
            'title': slide.title,
            'callouts': slide.callouts,
            'launch_url': slide.launch_url,
            'watch_video_id': slide.watch_video_id,
            'details_url': if slide.details? then '/' + @model.getId() + '/' + id + '/details' else ''
            'watch_url': if slide.watch_video_id? then '/' + @model.getId() + '/' + id + '/watch' else ''
            'picture_src': slide.picture_src,
            'clients': slide.clients,
            'mediums': slide.mediums,
            'tagline': slide.tagline
          })
          @slide_c[id] = new FeaturedWorkSlideController({
            'model': @slide_m[id]
          })

          if slide.details?
            $detail_el = $('#' + @model.getId() + '-' + id + '-detail')
            @work_detail_m[id] = new WorkDetailModel({
              '$el': $detail_el,
              'bg_src': slide.details.bg_src,
              'title': slide.details.title,
              'overview': slide.details.overview,
              'services': slide.details.services,
              'accolades': slide.details.accolades,
              'launch_url': slide.launch_url,
              'media': slide.details.media
            })
            @work_detail_c[id] = new WorkDetailController({
              'model': @work_detail_m[id]
            })
        else
          throw 'ERROR: slide type does not exist'

    # Cache selectors
    @$mask_wrapper = $('.mask-wrapper', @model.getV())
    @$slides_wrapper = $('.slides-wrapper', @model.getV())
    @$slide = $('.slide', @model.getV())

    @total_slides = @$slide.length
    @active_index = 0
    @active_c = null
    @active_work_detail_c = null

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

    # Loop and assign colors to each slide in order
    c = 0
    for n in [0...@$slide.length]
      @$slide.eq(n).attr('data-rgb', "#{LW.colors[c]}")
      c = if (c is LW.colors.length - 1) then 0 else c + 1

    # Build subnav if we're dealing with multiple slides
    # (Type of slides that'll double up on a dude like me!)
    @buildSubnav() if @total_slides > 1

  ###
  *------------------------------------------*
  | buildSubnav:void (-)
  |
  | Build subnav.
  *----------------------------------------###
  buildSubnav: ->
    links = _.map(@model.getSlideData(), (el, key) =>
      url = ''

      if key is LW.LANDING_SLIDE
        url = if @model.getId() is 'home' then '/' else '/' + @model.getId()
      else
        url = '/' + @model.getId() + '/' + key

      return {
        'id': key,
        'url': url,
        'title': el.browser_title
      }
    )

    @page_nav_m = new PageNavModel({
      '$el': $('.page-nav-zone', @model.getV()),
      'links': links
    })
    @page_nav_c = new PageNavController({
      'model': @page_nav_m
    })

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
    sub_type = if route.key.split(':')[2]? then route.key.split(':')[2] else ''

    # Reel exception
    if slide is 'reel'
      slide = _.keys(@model.getSlideData())[0]
      sub_type = 'reel'

    $new_slide = @slide_c[slide].model.getE()
    @active_index = $new_slide.index()

    # Page nav
    @page_nav_c.updatePageNav(slide) if @page_nav_c?

    # Active
    if @active_c is null
      @$slides_wrapper.hide() if sub_type isnt ''
      @setActive(slide, 'bottom')
      @setBackgroundColor($new_slide.attr('data-rgb'))
      @showSub(sub_type, true) if sub_type isnt ''

      _.delay(=>
        @$slides_wrapper.show()
      , 13)
    else if @slide_c[slide] is @active_c
      if sub_type isnt ''
        @showSub(sub_type)
      else
        @hideSub()
    else
      @hideSub()

      # Go to slide
      @$slide.removeClass('active')
      $new_slide.addClass('active')

      direction = if @active_index >= @active_c.model.getE().index() then 'bottom' else 'top'
      @active_c.transitionOut(direction, =>
        @setActive(slide, direction)
      )

      @setBackgroundColor($new_slide.attr('data-rgb'))

  ###
  *------------------------------------------*
  | setActive:void (-)
  |
  | slide:string - slide id
  | direction:string - transition direction
  |
  | Set active slide.
  *----------------------------------------###
  setActive: (slide, direction) ->
    s.suspend() for id, s of @slide_c
    @slide_c[slide].activate()
    @slide_c[slide].transitionIn(direction)
    @active_c = @slide_c[slide]

  ###
  *------------------------------------------*
  | showSub:void (-)
  |
  | sub:string - details / watch
  | no_trans:boolean - transition?
  |
  | Show details.
  *----------------------------------------###
  showSub: (sub, no_trans = false) ->
    @active_work_detail_c = null

    # Turn off event handlers
    @turnHandlers('off')

    # header
    LW.$body.trigger('gear_up_and_get_after_it')

    # suspend
    @watch_video_c.suspend()
    for work_detail of @work_detail_c
      @work_detail_c[work_detail].suspend()

    # activate
    if sub is 'reel'
      @watch_video_m.setWatchVideoId(@active_c.model.getReelVideoId())
      @watch_video_c.activate()

    if sub is 'details'
      @active_work_detail_c = @work_detail_c[LW.router.getState().key.split(':')[1]]
      @active_work_detail_c.activate()

    if sub is 'watch'
      @watch_video_m.setWatchVideoId(@active_c.model.getWatchVideoId())
      @watch_video_c.activate()

    # transition
    if no_trans is true
      @$mask_wrapper.addClass('no-trans')

    @$mask_wrapper[0].offsetHeight # clear CSS cache
    _.defer(=> @$mask_wrapper.addClass('unmask'))

  ###
  *------------------------------------------*
  | hideSub:void (-)
  |
  | Hide details.
  *----------------------------------------###
  hideSub: ->
    # If active work detail isnt null, turn off stuff
    if @active_work_detail_c isnt null
      @active_work_detail_c.turnDetailHandlers('off')
      @active_work_detail_c = null

    # header
    LW.$body.trigger('back_out_and_gear_down')

    # transition
    @$mask_wrapper.removeClass('no-trans')[0].offsetHeight # clear CSS cache
    _.defer(=> @$mask_wrapper.removeClass('unmask'))

    # Turn on event handlers
    @turnHandlers('on')

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
    @$mask_wrapper.css('background-color', "rgb(#{rgb})")

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
    
    if Math.abs(delta) >= 0.3 and @threshold_hit is false
      @threshold_hit = true
      if delta > 0
        @previous()
      else
        @next()

      setTimeout =>
        @threshold_hit = false
      , 1000

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

      if @direction_y >= 0 and @active_index is 0 or @direction_y <= 0 and @active_index is (@total_slides - 1)
        obj = {}
        obj[LW.utils.transform] = LW.utils.translate(0,"#{(@direction_y * 0.05) + 'px'}")
        @$slides_wrapper.css(obj)
      else
        c1 = @$slide.eq(@active_index).attr('data-rgb').split(',').map(Number)
        c2 = if @direction_y < 0 then @$slide.eq(@active_index + 1).attr('data-rgb').split(',').map(Number) else @$slide.eq(@active_index - 1).attr('data-rgb').split(',').map(Number)
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
    @$slides_wrapper.css(LW.utils.transform, LW.utils.translate('0px', 0 + 'px'))
    @dragging = false

    if @$slides_wrapper.hasClass('dragging')
      @$slides_wrapper.removeClass('dragging')

      if @now - @start_time < @drag_time and @current_range > @range or @current_range > (@$slides_wrapper.height() / 2)
        if @current_y < @start_y
          @next()
        if @current_y > @start_y
          @previous()
      else
        @setBackgroundColor(@$slide.eq(@active_index).attr('data-rgb'))

      return false

  ###
  *------------------------------------------*
  | previous:void (-)
  |
  | Previous slide, if there is one.
  *----------------------------------------###
  previous: ->
    if @active_index > 0
      @page_nav_c.previous(@active_index)

  ###
  *------------------------------------------*
  | next:void (-)
  |
  | Next slide, if there is one.
  *----------------------------------------###
  next: ->
    if @active_index < (@total_slides - 1)
      @page_nav_c.next(@active_index)

  ###
  *------------------------------------------*
  | turnHandlers:void (-)
  |
  | s:string - on / off
  |
  | Turn event handlers on / off.
  *----------------------------------------###
  turnHandlers: (s) ->
    LW.$doc.off("keyup.#{@model._id}")
    @$slides_wrapper.off("mousewheel DOMMouseScroll #{@mousedown} #{@mousemove}")

    if s is 'on'
      LW.$doc
        .on("keyup.#{@model._id}", @onKeyup)

      @$slides_wrapper
        .on("mousewheel DOMMouseScroll", @onMousewheel)
        .on(@mousedown, @onMouseDown)
        .on(@mousemove, @onMouseMove)

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

    # If there is more than one slide,
    # we have events to listen to...
    if @total_slides > 1
      # Turn on event handlers
      @turnHandlers('on')

      # Check if cookie is set
      if $.cookie('cookie_monster') is 'stuffed'
        LW.virgin = false
      else
        $.cookie('cookie_monster', 'stuffed', {expires: 13, path: '/'})

      # Now check if it's our first time and show or hide the nav
      if @page_nav_c?
        @page_nav_c.activate()

        if LW.virgin is true
          @page_nav_c.preview()
          LW.virgin = false

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

    # If there was more than one slide,
    # we have events to listen to turn off...
    if @total_slides > 1
      @turnHandlers('off')
      @hideSub()

module.exports = PageController