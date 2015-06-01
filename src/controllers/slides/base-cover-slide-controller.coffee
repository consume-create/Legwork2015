###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class BaseCoverSlideController extends BaseSlideController

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
    @interval = 0

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    super()
    @model.setV($(JST['cover-slide-view']({
      'id': @model.getId(),
      'base_video_path': @model.getBaseVideoPath()
    })))
    @model.getE().append(@model.getV())

    # Class vars
    @$vid_wrap = $('.cover-wrap', @model.getV())
    @layers = []

    # Scene size
    @scene_size = {'w': 1920, 'h': 1080}

    # PIXI Stage
    @stage = new PIXI.Container()
    @renderer = PIXI.autoDetectRenderer(1920, 1080, {'resolution': 1, 'transparent': false})
    @$vid_wrap.append(@renderer.view)

    # Base video layer / sprite
    @layers[0] = new PIXI.Container()
    @base_vid = if LW.utils.is_mobile.any() then PIXI.Texture.fromImage(@model.getFallbackPath()) else PIXI.Texture.fromVideo(@model.getBaseVideoPath())
    @base_vid.baseTexture.source.loop = true
    @base = new PIXI.Sprite(@base_vid)
    @base.width = @renderer.width
    @base.height = @renderer.height

    @layers[0].addChild(@base)
    @stage.addChild(@layers[0])

    $(@base_vid.baseTexture.source).one('playing', @resetBaseVideo())

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->

  ###
  *------------------------------------------*
  | resetBaseVideo:void (=)
  |
  | Reset base video.
  *----------------------------------------###
  resetBaseVideo: =>
    if @model.getE().is(':visible') is false
      @base_vid.baseTexture.source.pause()
      @base_vid.currentTime = 0

  ###
  *------------------------------------------*
  | render:void (=)
  |
  | Render.
  *----------------------------------------###
  render: =>
    @renderer.render(@stage)
    @frame = requestAnimationFrame(@render)

  ###
  *------------------------------------------*
  | pauseRenderer:void (-)
  |
  | s:string - on/off
  |
  | Pause the renderer.
  *----------------------------------------###
  turnRenderer: (s) ->
    cancelAnimationFrame(@frame)
    @resetBaseVideo() if LW.utils.is_mobile.any() is false

    if s is 'on'
      @base_vid.baseTexture.source.play() if LW.utils.is_mobile.any() is false
      @frame = requestAnimationFrame(@render)

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    super()
    @turnRenderer('on')

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    super()
    @turnRenderer('off')


module.exports = BaseCoverSlideController