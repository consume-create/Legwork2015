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
    @build()

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    @stage = new PIXI.Stage(0x000000)
    @renderer = PIXI.autoDetectRenderer(@model.getE().outerWidth(), @model.getE().outerHeight(), {'resolution': 2, 'transparent': true})
    @model.getE().html(@renderer.view)

    @t_wrap = new PIXI.DisplayObjectContainer()
    @stage.addChild(@t_wrap)

    @t_mask = new PIXI.Graphics()
    @t_mask.beginFill(0x00FF00)
    @t_mask.drawRect(0, 0, @renderer.width, @renderer.height)
    @t_mask.endFill()
    @t_mask.isMask = true
    @stage.addChild(@t_mask)
    @t_wrap.mask = @t_mask

    @bg = new PIXI.Graphics()
    @bg.beginFill(0x000000)
    @bg.drawRect(0, 0, @renderer.width, @renderer.height)
    @bg.endFill()
    @t_wrap.addChild(@bg)

  ###
  *------------------------------------------*
  | go:void (-)
  |
  | direction:string - left or right
  | cb:function - callback
  |
  | Go.
  *----------------------------------------###
  go: (direction, cb) ->
    TweenLite.to(@t_mask.scale, 0.666, {'x': 0, 'ease': Expo.easeInOut, 'onComplete': cb})

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
    @model.getE().hide()

    @t_mask.scale.x = 1
    cancelAnimationFrame(@frame)

module.exports = TransitionController