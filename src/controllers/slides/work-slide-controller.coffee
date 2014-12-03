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
    @$zone = $('.zone', @model.getV())

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (pos_in) ->
    obj = {}
    obj[LW.utils.transform] = LW.utils.translate(0, (pos_in * 100) + '%')
    @$title
      .addClass('no-trans')
      .css(obj)

    _.defer =>
      obj[LW.utils.transform] = LW.utils.translate(0, 0 + '%')
      @$title
        .removeClass('no-trans')
        .css(obj)

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (pos_out, cb) ->
    obj = {}
    obj[LW.utils.transform] = LW.utils.translate(0, (pos_out * 100) + '%')
    @$title
      .css(obj)
      .eq(0)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

module.exports = WorkSlideController