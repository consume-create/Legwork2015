###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class FeaturedWorkSlideController extends BaseSlideController

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
    @model.setV($(JST['featured-work-slide-view']({
      'title': @model.getTitle(),
      'callouts': @model.getCallouts(),
      'launch_url': @model.getLaunchUrl(),
      'details_url': @model.getDetailsUrl(),
      'watch_url': @model.getWatchUrl(),
      'picture_src': @model.getPictureSrc(),
      'clients': @model.getClients(),
      'mediums': @model.getMediums()
    })))
    @model.getE().append(@model.getV())

    @$title_holder = $('.title-holder', @model.getV())
    @$picture_zone = $('.picture-zone', @model.getV())

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | direction:string - top or bottom
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
      @$picture_zone
        .addClass('show')

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
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
    @$picture_zone
      .removeClass('show')

module.exports = FeaturedWorkSlideController