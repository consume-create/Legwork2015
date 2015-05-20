###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseFeatureSlideController = require './base-feature-slide-controller'

class WorkFeatureSlideController extends BaseFeatureSlideController

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
    @model.setV($(JST['work-feature-slide-view']({
      'title': @model.getTitle(),
      'callouts': @model.getCallouts(),
      'launch_url': @model.getLaunchUrl(),
      'details_url': @model.getDetailsUrl(),
      'watch_url': @model.getWatchUrl(),
      'picture_src': @model.getPictureSrc(),
      'clients': @model.getClients(),
      'mediums': @model.getMediums()
    })))

    super()

module.exports = WorkFeatureSlideController