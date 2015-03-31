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
    @model.setV($(JST['home-slide-view']()))
    @model.getE().append(@model.getV())
    # @$video_wrap = $('#home-video-wrap')
    # @$videos = $('video', @$video_wrap)
    # @alpha_v = @$videos.eq(0).get(0)
    # @zone_w = Math.ceil(@$video_wrap.outerWidth() / 7)
    # @reported = 0

    # @cnv = $('#stereoscope', @$video_wrap).get(0)
    # @ctx = @cnv.getContext('2d')

    # @observe()

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->
    @$videos.on('canplay', @onCanPlay)
    @$video_wrap.on('mousemove', @onWrapMove)

  ###
  *------------------------------------------*
  | onCanPlay:void (=)
  |
  | e:object - event object
  |
  | Handle can play.
  *----------------------------------------###
  onCanPlay: (e) =>
    @reported++
    @$video_wrap.trigger('canplayall') if @reported is (@$videos.length - 1)

  ###
  *------------------------------------------*
  | onCanPlayAll:void (=)
  |
  | e:object - event object
  |
  | Handle can play all.
  *----------------------------------------###
  onCanPlayAll: (e) =>
    cancelAnimationFrame(@frame)
    @frame = requestAnimationFrame(@render)

    @alpha_v.play()

  ###
  *------------------------------------------*
  | onWrapMove:void (=)
  |
  | e:object - event object
  |
  | Handle wrapper mouse move.
  *----------------------------------------###
  onWrapMove: (e) =>
    normal_x = (e.pageX - (@$video_wrap.offset().left + (@$video_wrap.outerWidth() * 0.25)))
    @zone = Math.max(Math.min(Math.floor(normal_x / @zone_w), (@$videos.length - 1)), 0)

  ###
  *------------------------------------------*
  | resize:void (-)
  |
  | Resize.
  *----------------------------------------###
  resize: ->
    #@zone_w = Math.ceil((@$video_wrap.outerWidth() * 0.5) / 7)

  ###
  *------------------------------------------*
  | render:void (=)
  |
  | Render.
  *----------------------------------------###
  render: =>
    vid = @$videos.eq(@zone).get(0)

    if vid isnt @alpha_v
      vid.currentTime = @alpha_v.currentTime

    _.defer(=>
      @ctx.drawImage(vid, 0, 0, 960, 540)
    )

    @frame = requestAnimationFrame(@render)

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    super()
    @resize()
    @model.getE().show()
    #@$video_wrap.off('canplayall').one('canplayall', @onCanPlayAll)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    super()
    #@$video_wrap.off('canplayall')
    #cancelAnimationFrame(@frame)

module.exports = HomeSlideController