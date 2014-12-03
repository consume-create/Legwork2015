###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class AboutProcessSlideController extends BaseSlideController

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
    @model.setV($(JST['about-process-slide-view']({
      'title': @model.getTitle()
    })))
    @model.getE().append(@model.getV())

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (pos_in) ->

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (pos_out, cb) ->
    cb()

module.exports = AboutProcessSlideController