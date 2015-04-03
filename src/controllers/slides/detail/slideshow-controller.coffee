###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class SlideshowController

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | init:object - init object
  |
  | Construct.
  *----------------------------------------###
  constructor: (init) ->
    @model = init.model
    @build()

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    @model.setV($(JST['slideshow-view']({
      'images': @model.getImages()
    })))
    @model.getE().append(@model.getV())

module.exports = SlideshowController