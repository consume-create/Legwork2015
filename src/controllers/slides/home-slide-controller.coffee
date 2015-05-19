###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class HomeSlideController extends BaseSlideController

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
    @model.setV($(JST['home-slide-view']({
      'instructions': @model.getInstructions()
    })))
    @model.getE().append(@model.getV())

    # Class vars
    @$vid_wrap = $('#home-video-wrap', @model.getV())
    @layers = []

    # Scene size
    @scene_size = {'w': 1000, 'h': 1000}

    # Player for base vid
    @player = $('#home-player', @model.getV()).get(0)

    # Buffer to get alpha channel data
    @buffer = document.createElement('canvas')
    @buffer.id = 'home-buffer'
    @buffer.width = @scene_size.w
    @buffer.height = (@scene_size.h * 2)

    # Output for alpha base video
    @output = document.createElement('canvas')
    @output.id = 'home-output'
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
    @texture = if LW.utils.is_mobile.any() then PIXI.Texture.fromImage('/images/home-fallback@2x.jpg') else PIXI.Texture.fromCanvas(@output)
    @base = new PIXI.Sprite(@texture)
    @layers[0].addChild(@base)
    @stage.addChild(@layers[0])

    console.log(@base)

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->

  ###
  *------------------------------------------*
  | drawCurrentBaseFrame:void (-)
  |
  | Draw the current frame from
  | the base animation.
  *----------------------------------------###
  drawCurrentBaseFrame: ->
    # Get video frame
    @buffer_ctx.drawImage(@player, 0, 0)

    # Get frame data
    image = @buffer_ctx.getImageData(0, 0, @scene_size.w, @scene_size.h)
    image_data = image.data
    alpha_data = @buffer_ctx.getImageData(0, @scene_size.h, @scene_size.w, @scene_size.h).data

    # Loop frame data and create alpha version
    for i in [3..image_data.length] by 4
      image_data[i] = alpha_data[i - 1]

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
    @drawCurrentBaseFrame() if LW.utils.is_mobile.any() is false
    @renderer.render(@stage)
    @frame = requestAnimationFrame(@render)

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    super()
    @player.play()
    cancelAnimationFrame(@frame)
    @frame = requestAnimationFrame(@render)
    @model.getE().show()

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    super()
    cancelAnimationFrame(@frame)
    @player.pause()

module.exports = HomeSlideController