###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class AppendixedWorkSlideController extends BaseSlideController

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
    @model.setV($(JST['appendixed-work-slide-view']({'projects': @model.getProjects()})))
    @model.getE().append(@model.getV())

    @$cell = $('.cell', @model.getV())

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (direction) ->
    @$cell
      .removeClass('trans-in trans-out top bottom')
      .addClass(direction)

    _.defer =>
      @$cell
        .addClass('trans-in')
        # .removeClass(direction)

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    n = if direction is 'top' then 0 else @$cell.length - 1

    @$cell
      .removeClass('trans-in trans-out top bottom')
      .addClass("#{direction} trans-out")
      .eq(n)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

module.exports = AppendixedWorkSlideController