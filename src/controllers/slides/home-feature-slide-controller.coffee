###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseFeatureSlideController = require './base-feature-slide-controller'

class HomeFeatureSlideController extends BaseFeatureSlideController

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
    @model.setV($(JST['home-feature-slide-view']({
      'id': @model.getId(),
      'subtitle': @model.getSubTitle(),
      'title': @model.getTitle(),
      'picture_src': @model.getPictureSrc(),
      'copy': @model.getCopy(),
      'lists': @model.getLists()
    })))

    super()
    @model.set$trans($('.info-holder', @model.getV()))

module.exports = HomeFeatureSlideController