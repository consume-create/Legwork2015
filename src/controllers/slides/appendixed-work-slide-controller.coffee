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
  | Transition in.
  *----------------------------------------###
  transitionIn: (pos_in) ->
    _.defer =>
      @$cell.addClass('active')

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (pos_out, cb) ->
    @$cell
      .removeClass('active')
      .eq(@$cell.length - 1)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

module.exports = AppendixedWorkSlideController