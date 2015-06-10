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
    @loader = new PIXI.loaders.Loader('/animations/', 1)
    @layers = []
    @mcs = {}

    # Scene size
    @scene_size = {'w': 1920, 'h': 1080}

    # PIXI for desktop, static for mobile
    if LW.utils.is_mobile.any()
      @$vid_wrap.css('background-image', 'url(' + @model.getFallbackPath() + ')').show()
    else
      # PIXI Stage
      @stage = new PIXI.Container()
      @renderer = PIXI.autoDetectRenderer(1920, 1080, {'resolution': 1, 'transparent': true})
      @$vid_wrap.append(@renderer.view)

      # Base video layer / sprite
      @layers[0] = new PIXI.Container()
      @base_vid = PIXI.Texture.fromVideo(@model.getBaseVideoPath())
      @base_vid.baseTexture.source.loop = true
      @base = new PIXI.Sprite(@base_vid)
      @base.width = @renderer.width
      @base.height = @renderer.height

      @layers[0].addChild(@base)
      @stage.addChild(@layers[0])
      @observe()

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->
    $(@base_vid.baseTexture.source).one('playing', @onBaseVideoPlay)

  ###
  *------------------------------------------*
  | onBaseVideoPlay:void (-)
  |
  | e:object - event object
  |
  | Handle base video play.
  *----------------------------------------###
  onBaseVideoPlay: (e) =>
    # Sample the color of the video
    # and use it as the slide bg color
    # to match the h264 color wash
    c = document.createElement('canvas').getContext('2d')
    c.drawImage(@base_vid.baseTexture.source, 10, 10, 20, 20, 0, 0, 20, 20)
    p = c.getImageData(0, 0, 20, 20).data
    l = p.length - 1
    r = g = b = 0

    # Average color of 400 pixels
    while l > 0
      r += p[l - 3]
      g += p[l - 2]
      b += p[l - 1]
      l -= 4

    ar = Math.round(r / 400)
    ag = Math.round(g / 400)
    ab = Math.round(b / 400)

    # Set it
    @model.getE().attr('data-rgb', ar + ',' + ag + ',' + ab)

    @$vid_wrap
      .css('background-color', 'rgb(' + ar + ',' + ag + ',' + ab + ')')
      .show()

    # PIXI autoplays the video, so ...
    @resetBaseVideo()

  ###
  *------------------------------------------*
  | loadAnimation:void (-)
  |
  | item:string - item to load
  | cb:function - callback
  |
  | Load an animation.
  *----------------------------------------###
  loadAnimation: (item, cb) ->
    @loader
      .add(item)
      .on('load', (loader, resource) =>
        if resource.isJson
          resource.on('afterMiddleware', (r) =>
            frames = r.data.frames
            name = _.keys(frames)[0]
            texture_id = name.substr(0, (name.length - 6))
            texture_ln = (_.size(frames) - 1)

            mc = new PIXI.extras.MovieClip(@mapTextures(texture_id, texture_ln, true))
            mc.animationSpeed = 28 / 60
            mc.gotoAndStop(0)

            cb(mc)
          )
      )
      .load()

  ###
  *------------------------------------------*
  | mapTextures:void (-)
  |
  | id:string - texture id
  | n:number - number of frames
  | leading_zero:boolean - leading zero?
  |
  | Map texures for a movie clip.
  *----------------------------------------###
  mapTextures: (id, n, leading_zero = false) ->
    textures = []

    for i in [0..n]
      if leading_zero is true and i < 10
        i = '0' + i

      textures.push(PIXI.Texture.fromFrame(id + i + '.png'))

    return textures

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
    if LW.utils.is_mobile.any() is false
      cancelAnimationFrame(@frame)
      @resetBaseVideo()

      if s is 'on'
        @base_vid.baseTexture.source.play()
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