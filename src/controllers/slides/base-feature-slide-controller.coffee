###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class BaseFeatureSlideController extends BaseSlideController

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
    @model.getE().append(@model.getV())
    @model.set$title($('.title-holder', @model.getV()))
    @model.set$photo($('.picture-zone', @model.getV()))

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (direction) ->
    @model.get$title()
      .removeClass('trans-in trans-out top bottom')
      .addClass(direction)

    _.defer(=>
      @model.get$title()
        .addClass('trans-in')
        .removeClass(direction)

      @model.get$photo()
        .addClass('show')
    )

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
  | cb:function - callback
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    @model.get$title()
      .removeClass('trans-in trans-out top bottom')
      .addClass("#{direction} trans-out")
      .eq(0)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

    @model.get$photo()
      .removeClass('show')

module.exports = BaseFeatureSlideController