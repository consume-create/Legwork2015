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
            '$el': $el
          })
          @slide_c[id] = new HomeSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.ABOUT
          @slide_m[id] = new AboutSlideModel({
            '$el': $el
          })
          @slide_c[id] = new AboutSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.ABOUT_PROCESS
          @slide_m[id] = new AboutProcessSlideModel({
            '$el': $el,
            'title': slide.title
          })
          @slide_c[id] = new AboutProcessSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.WORK
          @slide_m[id] = new WorkSlideModel({
            '$el': $el
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
            'launch_url': slide.launch_url,
            'tagline': slide.tagline,
            'picture_src': slide.picture_src,
            'clients': slide.clients,
            'mediums': slide.mediums,
            'poster_src': slide.details.poster_src,
            'poster_cta': slide.details.poster_cta,
            'vimeo_id': slide.details.vimeo_id,
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
            'projects': slide.projects
          })
          @slide_c[id] = new AppendixedWorkSlideController({
            'model': @slide_m[id]
          })
        else
          throw 'ERROR: slide type does not exist'

      @$slides = $('.slide')

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

    s.suspend() for id, s of @slide_c
    @slide_c[slide].activate()
    @active_c = @slide_c[slide]
    @$page_btns.removeClass('active').filter('[data-id="' + slide+ '"]').addClass('active')

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @model.getE().show()

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    @model.getE().hide()
    s.suspend() for id, s of @slide_c

module.exports = PageController