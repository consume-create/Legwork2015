###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class CoverSlideController extends BaseSlideController

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
      'base_video_path': @model.getBaseVideoPath(),
      'watch_url': @model.getWatchUrl()
    })))
    @model.getE().append(@model.getV())

    # Class vars
    @$vid_wrap = $('.cover-wrap', @model.getV())
    @$cnv_wrap = $('.cnv-wrap', @model.getV())
    @$video = $('video', @$cnv_wrap)

    LW.utils.is_mobile.any = ->
      return true

    # Scene size
    @scene_size = {'w': 1600, 'h': 900}

    LW.utils.is_mobile.any = =>
      return true

    # PIXI for desktop, static for mobile
    if LW.utils.is_mobile.any()
      _.delay(=>
        @$vid_wrap
          .css({
            'background-color': 'rgba(' + @model.getE().data('rgb') + ', 1)',
            'background-image': 'url(' + @model.getFallbackPath() + ')'
          })
          .addClass('roll')
      , 333)
    else
      @observe()

  ###
  *------------------------------------------*
  | observe:void (-)
  |
  | Observe.
  *----------------------------------------###
  observe: ->
    @$video.show().one('playing', @onBaseVideoPlay)

  ###
  *------------------------------------------*
  | resize:void (-)
  |
  | Resize.
  *----------------------------------------###
  resize: ->
    @$cnv_wrap.css({
      'width': (LW.size.app[1] * (@scene_size.w / @scene_size.h)) + 'px'
      'height': LW.size.app[1] + 'px'
    })

  ###
  *------------------------------------------*
  | onBaseVideoPlay:void (-)
  |
  | e:object - event object
  |
  | Handle base video play.
  *----------------------------------------###
  onBaseVideoPlay: (e) =>
    _.delay(=>
      # Sample the color of the video
      # and use it as the slide bg color
      # to match the h264 color wash
      c = document.createElement('canvas').getContext('2d')
      c.drawImage(@$video.get(0), 10, 10, 20, 20, 0, 0, 20, 20)
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
        .addClass('roll')

      # Safari has issues even when we match the color ...
      @$cnv_wrap.addClass('blend') if !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/)
    , 500) # IE needs a minute

  ###
  *------------------------------------------*
  | resetBaseVideo:void (=)
  |
  | Reset base video.
  *----------------------------------------###
  resetBaseVideo: =>
    if @model.getE().is(':visible') is false
      @$video.get(0).pause()

      _.defer(=>
        @$video.currentTime = 0
      )

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
      @resetBaseVideo()

      if s is 'on'
        @$video.get(0).play()

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (direction) ->
    @model.getV().removeClass('hide-cover')
    @model.getV()[0].offsetHeight
    @model.getV().addClass('show-cover')

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
  | cb:function - callback
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    @model.getV()
      .removeClass('show-cover')
      .addClass('hide-cover')
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    super()
    @resize() if LW.utils.is_mobile.any() is false
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


module.exports = CoverSlideController