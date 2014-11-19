###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Slides
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
    @model.setV($('<div id="' + @model.getId() + '-page-inner" class="page-inner"/>'))
    @model.getE().append(@model.getV())

    # Loop and create page slides
    for id, slide of @model.getSlideData()
      $el = $('<div id="' + @model.getId() + '-' + id + '" class="slide featured-work" />').appendTo(@model.getV())
      @slide_m[id] = new FeaturedWorkSlideModel({'$el': $el})
      @slide_c[id] = new FeaturedWorkSlideController({
        'model': @slide_m[id]
      })

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