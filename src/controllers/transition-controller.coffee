###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class TransitionController

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
    @scale = [1, 1]
    @running_hot = false
    @animation_to = -1

    @build()

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    # Stage
    @stage = new PIXI.Container(0x000000)
    @renderer = PIXI.autoDetectRenderer(LW.size.app[0], LW.size.app[1], {'resolution': 1, 'transparent': true})
    @model.getE().html(@renderer.view)

    @$canvas = $(@renderer.view)
    @$canvas.css({
      'width': LW.size.app[0] + 'px',
      'height': LW.size.app[1] + 'px'
    })

    # Wipe
    @wipe = new PIXI.Graphics()
    @wipe.position = new PIXI.Point(LW.size.app[0], 0)
    @stage.addChild(@wipe)

    # Resize
    @resize()

    # Animations
    @animationQueue = []
    @loadAnimationQueue()

  ###
  *------------------------------------------*
  | loadAnimationQueue:void (-)
  |
  | Load the animation queue behind
  | the scenes.
  *----------------------------------------###
  loadAnimationQueue: ->
    @loader = new PIXI.loaders.Loader('/animations/', 1)
    @loader
      .add([
        'transition-1.json',
        'transition-2.json',
        'transition-3.json'
      ])
      .on('load', @animationQueueProgress)
      .load()

  ###
  *------------------------------------------*
  | animationQueueProgress:void (-)
  |
  | loader:object - PIXI Loader
  | resource:object - current resource
  |
  | Animation queue progress.
  *----------------------------------------###
  animationQueueProgress: (loader, resource) =>
    if resource.isJson
      resource.on('afterMiddleware', (r) =>
        frames = r.data.frames
        name = _.keys(frames)[0]
        texture_id = name.substr(0, (name.length - 6))
        texture_ln = (_.size(frames) - 1)

        mc = new PIXI.extras.MovieClip(@mapTextures(texture_id, texture_ln, true))
        mc.visible = false
        mc.animationSpeed = 30 / 60
        mc.loop = false
        mc.position = new PIXI.Point(0, 0)
        mc.scale = new PIXI.Point(@scale[0], @scale[1])
        @stage.addChild(mc)
        mc.gotoAndStop(0)
        @animationQueue.push(mc)
      )

  ###
  *------------------------------------------*
  | resize:void (-)
  |
  | Resize.
  *----------------------------------------###
  resize: ->
    @renderer.resize(LW.size.app[0], LW.size.app[1])
    @$canvas.css({
      'width': LW.size.app[0] + 'px',
      'height': LW.size.app[1] + 'px'
    })

    scale_factor = if LW.size.app[0] > LW.size.app[1] then (LW.size.app[0] / 960) else (LW.size.app[1] / 540)
    @scale = [scale_factor, scale_factor]

    @wipe.clear()
    @wipe.beginFill(0x000000, 1)
    @wipe.drawRect(0, 0, LW.size.app[0], LW.size.app[1])
    @wipe.endFill()

  ###
  *------------------------------------------*
  | go:void (-)
  |
  | direction:string - left or right
  | cb1:function - stage 1 callback
  | cb2:function - stage 2 callback
  |
  | Go.
  *----------------------------------------###
  go: (direction, cb1, cb2) ->
    @running_hot = true

    _.defer(=>
      a = _.sample(@animationQueue) || new PIXI.Container()
      x1 = 0
      x2 = -LW.size.app[0]

      if direction is 'right'
        a.scale = new PIXI.Point(-@scale[0], @scale[1])
        a.position.x = -a.width

        @wipe.position.x = -LW.size.app[0]
        x2 *= -1

      # Sequence
      a.position.x -= (((960 * @scale[0]) - LW.size.app[0]) / 2)
      a.position.y -= (((540 * @scale[1]) - LW.size.app[1]) / 2)
      a.visible = true
      a.gotoAndPlay(0) if a.gotoAndPlay?

      _.delay(=>
        TweenLite.to(@wipe.position, 0.666, {
          'x': x1,
          'ease': Expo.easeIn,
          'overwrite': true,
          'onComplete': =>
            cb1()

            _.delay(=>
              a.visible = false

              TweenLite.to(@wipe.position, 0.666, {
                'x': x2,
                'ease': Expo.easeOut,
                'overwrite': true,
                'onComplete': =>
                  cb2()
              })
            , 333)
        })
      , 100)
    )

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
  | suspendAllAnimations:void (-)
  |
  | Suspend the animations, all of them.
  *----------------------------------------###
  suspendAllAnimations: ->
    for a in @animationQueue
      a.visible = false
      a.scale = new PIXI.Point(@scale[0], @scale[1])
      a.position.x = 0
      a.gotoAndStop(0)

    @wipe.visible = true
    @wipe.position = new PIXI.Point(LW.size.app[0], 0)

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
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @frame = requestAnimationFrame(@render)
    @model.getE().show()

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    clearTimeout(@animation_to)
    @suspendAllAnimations()
    cancelAnimationFrame(@frame)
    @model.getE().hide()

module.exports = TransitionController