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
    @stage = new PIXI.Stage(0x000000)
    @renderer = PIXI.autoDetectRenderer(LW.size.app[0], LW.size.app[1], {'resolution': 2})
    @model.getE().html(@renderer.view)

    @$canvas = $(@renderer.view)
    @$canvas.css({
      'width': LW.size.app[0] + 'px',
      'height': LW.size.app[1] + 'px'
    })

    @loadAnimationQueue()

  ###
  *------------------------------------------*
  | loadAnimationQueue:void (-)
  |
  | Load the animation queue behind
  | the scenes.
  *----------------------------------------###
  loadAnimationQueue: ->
    @animationQueue = []

    # TODO: random sample of available animations
    loader = new PIXI.AssetLoader(['/animations/ben-test-2.json'])
    loader.onProgress = @animationQueueProgress
    loader.load()

  ###
  *------------------------------------------*
  | animationQueueProgress:void (-)
  |
  | Animation queue progress.
  *----------------------------------------###
  animationQueueProgress: =>
    # TODO: how to get id, frames?
    mc = new PIXI.MovieClip(@mapTextures('Transition4_Test1_', 38, true))
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
    @scale = [(LW.size.app[0] / 1920), (LW.size.app[0] / 1920)]

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
      a = _.sample(@animationQueue)
      if direction is 'right'
        a.scale = new PIXI.Point(-@scale[0], @scale[1])
        a.position.x -= a.width

      # Sequence
      a.gotoAndPlay(0)

      # Layer
      @model.getE()
        .addClass('in-' + direction)
        .off(LW.utils.transition_end)
        .one(LW.utils.transition_end, =>
          clearTimeout(@animation_to)
          @animation_to = setTimeout(=>
            @model.getE()
              .addClass('out-' + direction)
              .off(LW.utils.transition_end)
              .one(LW.utils.transition_end, =>
                cb2()
                @running_hot = false
              )
          , 200)
          cb1()
        )
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
      a.scale = new PIXI.Point(@scale[0], @scale[1])
      a.position.x = 0
      a.gotoAndStop(0)

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