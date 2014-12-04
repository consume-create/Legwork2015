###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class WorkSlideController extends BaseSlideController

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

    @model.setV($(JST['work-slide-view']({
      'title': @model.getTitle(),
      'instructions': @model.getInstructions()
    })))
    @model.getE().append(@model.getV())

    @$title = $('.title-holder h2', @model.getV())

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (direction) ->
    @$title
      .removeClass('trans-in trans-out top bottom')
      .addClass(direction)

    _.defer =>
      @$title
        .addClass('trans-in')
        .removeClass(direction)

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    @$title
      .removeClass('trans-in trans-out top bottom')
      .addClass("#{direction} trans-out")
      .eq(0)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

module.exports = WorkSlideController