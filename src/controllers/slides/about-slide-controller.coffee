###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class AboutSlideController extends BaseSlideController

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | init:object - init object
  |
  | Construct.
  *----------------------------------------###
  constructor: (init) ->
    super(init)

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    super()

    @model.setV($(JST['about-slide-view']()))
    @model.getE().append(@model.getV())

module.exports = AboutSlideController