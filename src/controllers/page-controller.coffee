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

    # TODO: loop through data and create
    @slide_m[0] = new FeaturedWorkSlideModel({
      '$el': @model.getV() # TODO: for now
    })
    @slide_c[0] = new FeaturedWorkSlideController({
      'model': @slide_m[0]
    })

module.exports = PageController