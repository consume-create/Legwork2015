###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Slides
HomeSlideModel = require '../models/slides/home-slide-model'
HomeSlideController = require './slides/home-slide-controller'
LandingSlideModel = require '../models/slides/landing-slide-model'
LandingSlideController = require './slides/landing-slide-controller'
FeaturedWorkSlideModel = require '../models/slides/featured-work-slide-model'
FeaturedWorkSlideController = require './slides/featured-work-slide-controller'

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
    @model.setV($(JST['page-view']({'id': @model.getId()})))
    @model.getE().append(@model.getV())

    # Cache selectors
    @$slide_wrapper = $('.slides-wrapper', @model.getV())
    @$page_nav = $('.page-nav', @model.getV())

    # Loop and create page slides

    # NOTE:
    # To add a new slide type, you must:
    # 1. Define a const slide type in ./env
    # 2. Add a data file to ./data/* where you would like to use the slide
    # 3. Add the slide model, view and controller (extend the base model and controller classes)
    # 4. Require the model and controller in the page controller and add a condition to the build method

    for id, slide of @model.getSlideData()
      $el = $('<div id="' + @model.getId() + '-' + id + '" class="slide ' + slide.slide_type + '" />').appendTo(@$slide_wrapper)

      switch slide.slide_type
        when LW.slide_types.HOME
          @slide_m[id] = new HomeSlideModel({'$el': $el})
          @slide_c[id] = new HomeSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.LANDING
          @slide_m[id] = new LandingSlideModel({'$el': $el})
          @slide_c[id] = new LandingSlideController({
            'model': @slide_m[id]
          })
        when LW.slide_types.FEATURED_WORK
          @slide_m[id] = new FeaturedWorkSlideModel({
            '$el': $el,
            'title': slide.title,
            'launch_url': slide.launch_url,
            'picture_src': slide.picture_src,
            'clients': slide.clients,
            'mediums': [
              LW.mediums.DESKTOP,
              LW.mediums.MOBILE
            ],
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
        else
          throw 'ERROR: slide type does not exist'

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

module.exports = PageController