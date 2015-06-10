###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseFeatureSlideController = require './base-feature-slide-controller'

class RecognitionFeatureSlideController extends BaseFeatureSlideController

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
    @model.setV($(JST['recognition-feature-slide-view']({
      'id': @model.getId(),
      'subtitle': @model.getSubTitle(),
      'title': @model.getTitle(),
      'picture_src': @model.getPictureSrc(),
      'copy': @model.getCopy()
    })))

    super()
    @model.set$trans($('.info-holder', @model.getV()))
    @buildPile() if LW.utils.is_mobile.any() is false

  ###
  *------------------------------------------*
  | buildPile:void (-)
  |
  | Build the award pile.
  *----------------------------------------###
  buildPile: ->
    @$pile = $('#recognition-pile', @model.getV())
    @engine = Matter.Engine.create(@$pile.get(0), {
      'render': {
        'options': {
          'wireframes': false,
          'background': 'transparent',
          'width': 2800,
          'height': 1280
        }
      }
    })
    @textures = [
      '/images/awards/fwa.png',
      '/images/awards/one.png',
      '/images/awards/webby.png'
    ]

    @engine.world.bounds.min.x = -Infinity
    @engine.world.bounds.min.y = -Infinity
    @engine.world.bounds.max.x = Infinity
    @engine.world.bounds.max.y = Infinity

  ###
  *------------------------------------------*
  | initPile:void (-)
  |
  | Init the award pile.
  *----------------------------------------###
  initPile: ->
    bodies = []
    for obj in @model.getAwards()
      for i in [0..obj.count]
        bodies.push(Matter.Bodies.circle((Math.round(Math.random() * 200) + 1400), -(Math.round(Math.random() * 4960) + 80), 40, {
          'render': {
            'sprite': {
              'texture': obj.texture
            }
          }
        }))

    # Floor
    bodies.push(Matter.Bodies.rectangle(1400, 1290, 2800, 20, {
      'isStatic': true,
      'render': {
        'visible': false
      }
    }))

    # Right wall
    bodies.push(Matter.Bodies.rectangle(2810, 640, 20, 1280, {
      'isStatic': true,
      'render': {
        'visible': false
      }
    }))

    Matter.World.add(@engine.world, bodies)

  ###
  *------------------------------------------*
  | render:void (=)
  |
  | Render.
  *----------------------------------------###
  render: =>
    @frame = requestAnimationFrame(@render)
    Matter.Engine.update(@engine, (1000 / 60), 1)
    Matter.Engine.render(@engine)

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: =>
    super()

    # Build award pile
    if LW.utils.is_mobile.any() is false
      Matter.World.clear(@engine.world, false)
      @initPile()

      # Start renderer
      cancelAnimationFrame(@frame)
      @frame = requestAnimationFrame(@render)

      # Pause renderer in 15 seconds
      clearTimeout(@done_to)
      @done_to = setTimeout(=>
        cancelAnimationFrame(@frame)
      , 15000)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: =>
    super()

    # Destroy award pile
    if LW.utils.is_mobile.any() is false
      clearTimeout(@done_to)
      cancelAnimationFrame(@frame)
      Matter.World.clear(@engine.world, false)

module.exports = RecognitionFeatureSlideController