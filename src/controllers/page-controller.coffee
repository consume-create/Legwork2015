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

    # Cache selectors
    @$slide_wrapper = $('.slides-wrapper', @model.getV())
    @$page_btns = $('.page-nav li a', @model.getV())
    @total_page_btns = @$page_btns.length

    @active_c = null
    @active_index = 0
    @old_index = 0
    @threshold_hit = false
    @scroll = 0
    @scroll_dir = 1

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
            'title': slide.title,
            'picture_src': slide.picture_src
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
    @scroll = 0

  ###
  *------------------------------------------*
  | setBackgroundColor:void (-)
  |
  | Set background color.
  *----------------------------------------###
  setBackgroundColor: (rgb) ->
    @model.getE().css('background-color': "rgb(#{rgb})")

  ###
  *------------------------------------------*
  | onMousewheel:void (=)
  |
  | Rip'it with the mousewheel.
  *----------------------------------------###
  onMousewheel: (e) =>
    e.preventDefault()

    delta = e.originalEvent.wheelDelta / 120 or -e.originalEvent.detail / 3

    # if @threshold_hit is false
    #   @old_scroll = @scroll
    #   n = if delta > 0 then -1 else 1
    #   @scroll = Math.min(Math.max((@scroll + n), -100), 100)

    #   if @scroll >= @old_scroll
    #     @scroll_dir = 1
    #   else
    #     @scroll_dir = -1

    #   console.log Math.abs(@scroll)
    
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
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @model.getE().show()

    # If there are page_btns,
    # we have events to listen to...
    if @total_page_btns > 1
      @scroll = 0
      @scroll_dir = 1

      LW.$doc
        .off("mousewheel.#{@model._id} DOMMouseScroll.#{@model._id} keyup.#{@model._id}")
        .on("mousewheel.#{@model._id} DOMMouseScroll.#{@model._id}", @onMousewheel)
        .on("keyup.#{@model._id}", @onKeyup)

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
      LW.$doc.off("mousewheel.#{@model._id} DOMMouseScroll.#{@model._id} keyup.#{@model._id}")

module.exports = PageController