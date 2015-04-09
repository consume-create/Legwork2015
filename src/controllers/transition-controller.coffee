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
    @scale = [(LW.size.app[0] / 960), (LW.size.app[0] / 960)]
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
    @stage = new PIXI.Stage(0x000000)
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
    @wipe.beginFill(0x000000, 1)
    @wipe.drawRect(0, 0, LW.size.app[0], LW.size.app[1])
    @wipe.endFill()
    @stage.addChild(@wipe)

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
    loader = new PIXI.AssetLoader(['/animations/transition-1.json'])
    loader.onProgress = @animationQueueProgress
    loader.load()

  ###
  *------------------------------------------*
  | animationQueueProgress:void (-)
  |
  | loader:object - pixi loader
  |
  | Animation queue progress.
  *----------------------------------------###
  animationQueueProgress: (loader) =>
    frames = loader.json.frames
    name = _.keys(frames)[0]
    texture_id = name.substr(0, (name.length - 6))
    texture_ln = (_.size(frames) - 1)

    mc = new PIXI.MovieClip(@mapTextures(texture_id, texture_ln, true))
    mc.visible = false
    mc.animationSpeed = 24 / 60
    mc.loop = false
    mc.position = new PIXI.Point(0, 0)
    mc.scale = new PIXI.Point(@scale[0], @scale[1])
    @stage.addChild(mc)
    mc.gotoAndStop(0)
    @animationQueue.push(mc)

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
    @scale = [(LW.size.app[0] / 960), (LW.size.app[0] / 960)]

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
      a = _.sample(@animationQueue) # TODO: if none have loaded ...
      x1 = 0
      x2 = -LW.size.app[0]

      if direction is 'right'
        a.scale = new PIXI.Point(-@scale[0], @scale[1])
        a.position.x = -a.width

        @wipe.position.x = -LW.size.app[0]
        x2 *= -1

      # Sequence
      a.visible = true
      a.gotoAndPlay(0)

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
    @model.getE().show()[0].offsetHeight

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
    @model.getE().off(LW.utils.transition_end).hide().removeClass('in-left in-right out-left out-right')

module.exports = TransitionController