###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class AppendixedWorkSlideController extends BaseSlideController

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
    @model.setV($(JST['appendixed-work-slide-view']({
      'projects': @model.getProjects()
    })))
    @model.getE().append(@model.getV())

    @$cell = $('.cell', @model.getV())
    @$watch_btn = $('.watch-btn', @model.getV())

    @$video_zone = $('.video-zone', @model.getV())
    @$video_close_zone = $('.video-close-zone', @model.getV())
    @$video_iframe = $('.video-iframe', @model.getV())

  ###
  *------------------------------------------*
  | onClickWatchBtn:void (=)
  |
  | Click watch btn.
  | Reset, build, and show video.
  *----------------------------------------###
  onClickWatchBtn: (e) =>
    $t = $(e.currentTarget)
    id = $t.data('id')

    @buildVideo(id)
    @showVideoZone()

  ###
  *------------------------------------------*
  | onClickCloseVideoZone:void (=)
  |
  | Click close video btn.
  *----------------------------------------###
  onClickCloseVideoZone: =>
    @hideVideoZone()
    @removeVideos()

  ###
  *------------------------------------------*
  | showVideoZone:void (=)
  |
  | Show video zone.
  *----------------------------------------###
  showVideoZone: (e) =>
    @$video_zone.addClass('show')

  ###
  *------------------------------------------*
  | hideVideoZone:void (=)
  |
  | Hide video zone.
  *----------------------------------------###
  hideVideoZone: =>
    @$video_zone.removeClass('show')

  ###
  *------------------------------------------*
  | buildVideo:void (=)
  |
  | Build video.
  *----------------------------------------###
  buildVideo: (id) =>
    @removeVideos()
    $v = $('<iframe src="//player.vimeo.com/video/' + id + '?title=0&amp;byline=0&amp;portrait=0&amp;color=ffffff&amp;autoplay=1&amp;api=1&amp;player_id=player" id="player" width="960" height="540" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>')
    
    @$video_iframe.empty().append($v)

  ###
  *------------------------------------------*
  | removeVideos:void (=)
  |
  | Remove videos.
  *----------------------------------------###
  removeVideos: =>
    if $('iframe', @model.getV()).length > 0
      @$video_iframe.empty()

  ###
  *------------------------------------------*
  | reset:void (=)
  |
  | Reset.
  *----------------------------------------###
  reset: =>
    @removeVideos()
    @hideVideoZone()

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (direction) ->
    @$cell
      .removeClass('trans-in trans-out top bottom')
      .addClass(direction)

    _.defer =>
      @$cell
        .addClass('trans-in')
        # .removeClass(direction)

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    n = if direction is 'top' then 0 else @$cell.length - 1

    @$cell
      .removeClass('trans-in trans-out top bottom')
      .addClass("#{direction} trans-out")
      .eq(n)
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

    @$watch_btn
      .off()
      .on('click', @onClickWatchBtn)

    @$video_close_zone
      .off()
      .on('click', @onClickCloseVideoZone)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    super()

    @$watch_btn.off()
    @$video_close_zone.off()

    @reset()

module.exports = AppendixedWorkSlideController