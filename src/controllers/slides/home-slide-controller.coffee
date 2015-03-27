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

    @$video_wrap = $('#home-video-wrap')
    @$videos = $('video', @$video_wrap)
    @zone_w = Math.ceil(@$video_wrap.outerWidth() / 7)
    @reported = 0
    @playing = false

    @observe()

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->
    @$videos.on('canplay', @onCanPlay)
    @$video_wrap
      .on('mousemove', @onWrapMove)
      .on('canplayall', @onCanPlayAll)

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
    @alpha_v = @$videos.eq(0).get(0)
    @$videos.each((id, el) => el.play())

    @playing = true

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
    zone = Math.max(Math.min(Math.floor(normal_x / @zone_w), (@$videos.length - 1)), 0)

    @$videos.hide().eq(zone).show()

  ###
  *------------------------------------------*
  | resize:void (-)
  |
  | Resize.
  *----------------------------------------###
  resize: ->
    @zone_w = Math.ceil((@$video_wrap.outerWidth() * 0.5) / 7)

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

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    super()

module.exports = HomeSlideController