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
    @scene_size = {'w': 1000, 'h': 1000}

    # Player for base vid
    @$player = $('#' + @model.getId() + '-player', @model.getV())
    @player = @$player.get(0)

    # Buffer to get alpha channel data
    @buffer = document.createElement('canvas')
    @buffer.id = @model.getId() + '-buffer'
    @buffer.width = @scene_size.w
    @buffer.height = (@scene_size.h * 2)

    # Output for alpha base video
    @output = document.createElement('canvas')
    @output.id = @model.getId() + '-output'
    @output.width = @scene_size.w
    @output.height = @scene_size.h

    # Contexts
    @buffer_ctx = @buffer.getContext('2d')
    @output_ctx = @output.getContext('2d')

    # PIXI Stage
    @stage = new PIXI.Container()
    @renderer = PIXI.autoDetectRenderer(1000, 1000, {'resolution': 1, 'transparent': true})
    @$vid_wrap.append(@renderer.view)

    # Base video layer / sprite
    @layers[0] = new PIXI.Container()
    @texture = if LW.utils.is_mobile.any() then PIXI.Texture.fromImage(@model.getFallbackPath()) else PIXI.Texture.fromCanvas(@output)
    @base = new PIXI.Sprite(@texture)
    @layers[0].addChild(@base)
    @stage.addChild(@layers[0])

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->

  ###
  *------------------------------------------*
  | drawCurrentBaseFrame:void (=)
  |
  | Draw the current frame from
  | the base animation.
  *----------------------------------------###
  drawCurrentBaseFrame: =>
    # Get video frame
    @buffer_ctx.drawImage(@player, 0, 0)

    # Get frame data
    image = @buffer_ctx.getImageData(0, 0, @scene_size.w, @scene_size.h)
    image_data = image.data
    alpha_data = @buffer_ctx.getImageData(0, @scene_size.h, @scene_size.w, @scene_size.h).data
    pixels = (image_data.length - 1)

    # Loop frame data and create alpha version
    while (pixels -= 4) > 0
      image_data[pixels] = alpha_data[pixels - 1]

    # Put frame data on render canvas
    @output_ctx.putImageData(image, 0, 0, 0, 0, @scene_size.w, @scene_size.h)

    # Base video texture needs update
    @base.texture.update()

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
    clearInterval(@interval)
    @player.pause()

    if s is 'on'
      @player.play()
      @interval = setInterval(@drawCurrentBaseFrame, 40) if LW.utils.is_mobile.any() is false
      @frame = requestAnimationFrame(@render)

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @drawCurrentBaseFrame()
    @renderer.render(@stage)

    super()

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    super()

    @turnRenderer('off')
    @player.currentTime = 0

module.exports = BaseCoverSlideController