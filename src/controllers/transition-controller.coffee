###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class TransitionController

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
    # TODO: aspect ratio w + h
    @stage = new PIXI.Stage(0x000000)
    @renderer = PIXI.autoDetectRenderer(@model.getE().outerWidth(), @model.getE().outerHeight(), null, true)
    @model.getE().html(@renderer.view)

module.exports = TransitionController