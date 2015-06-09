###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseFeatureSlideController = require './base-feature-slide-controller'

class RecognitionFeatureSlideController extends BaseFeatureSlideController

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
    @model.setV($(JST['recognition-feature-slide-view']({
      'id': @model.getId(),
      'subtitle': @model.getSubTitle(),
      'title': @model.getTitle(),
      'picture_src': @model.getPictureSrc(),
      'copy': @model.getCopy(),
      'awards': @model.getAwards()
    })))

    super()
    @model.set$trans($('.info-holder', @model.getV()))
    console.log(@model.getAwards())

module.exports = RecognitionFeatureSlideController