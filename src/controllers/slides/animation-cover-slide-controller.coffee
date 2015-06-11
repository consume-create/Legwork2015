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

    # TODO: keep this for later ...
    # Load cover specific animations
    #@loadAnimation('about-cta.json', @onAboutCTALoaded)

  ###
  *------------------------------------------*
  | onAboutCTALoaded:void (=)
  |
  | mc:pixi - the loaded mc
  |
  | About CTA has loaded.
  *----------------------------------------###
  # onAboutCTALoaded: (mc) =>
  #   @about_cta = mc

module.exports = AnimationCoverSlideController