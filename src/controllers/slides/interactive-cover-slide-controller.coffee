###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseCoverSlideController = require './base-cover-slide-controller'

class InteractiveCoverSlideController extends BaseCoverSlideController

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

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->
    super()

    @model.getV().on('click', (e) =>
      History.pushState(null, null, @model.getWatchUrl())
    )

module.exports = InteractiveCoverSlideController