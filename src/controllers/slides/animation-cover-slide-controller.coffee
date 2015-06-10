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

    # Load cover specific animations
    @loadAnimation('about-cta.json', @onAboutCTALoaded)

  ###
  *------------------------------------------*
  | onAboutCTALoaded:void (=)
  |
  | mc:pixi - the loaded mc
  |
  | About CTA has loaded.
  *----------------------------------------###
  onAboutCTALoaded: (mc) =>
    @about_cta = mc
    @about_cta.position = new PIXI.Point(1200, 700)
    @about_cta.buttonMode = true
    @about_cta.interactive = true
    @stage.addChild(@about_cta)
    @about_cta.gotoAndStop(0)

    # Events
    @about_cta.on('mouseover', (e) => @about_cta.gotoAndPlay(0))
    @about_cta.on('mouseout', (e) => @about_cta.gotoAndStop(0))
    @about_cta.on('mousedown', (e) => History.pushState(null, null, @model.getWatchUrl()))
    @about_cta.on('touchstart', (e) => History.pushState(null, null, @model.getWatchUrl()))

module.exports = AnimationCoverSlideController