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
      'title': @model.getTitle(),
      'picture_src': @model.getPictureSrc()
    })))
    @model.getE().append(@model.getV())

    @$title_holder = $('.title-holder', @model.getV())

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (direction) ->
    @$title_holder
      .removeClass('trans-in trans-out top bottom')
      .addClass(direction)

    _.defer =>
      @$title_holder
        .addClass('trans-in')
        .removeClass(direction)

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    @$title_holder
      .removeClass('trans-in trans-out top bottom')
      .addClass("#{direction} trans-out")
      .eq(0)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

module.exports = AboutProcessSlideController