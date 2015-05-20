###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseCoverSlideController = require './base-cover-slide-controller'

class AnimationCoverSlideController extends BaseCoverSlideController

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
    @observe()

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->
    @model.getV().on('click', (e) =>
      History.pushState(null, null, @model.getWatchUrl())
    )

module.exports = AnimationCoverSlideController