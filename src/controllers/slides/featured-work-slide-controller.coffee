###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class FeaturedWorkSlideController extends BaseSlideController

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
    @model.setV($(JST['featured-work-slide-view']({
      'title': @model.getTitle(),
      'rgb': @model.getRgb(),
      'callouts': @model.getCallouts(),
      'vimeo_id': @model.getVimeoId(),
      'launch_url': @model.getLaunchUrl(),
      'tagline': @model.getTagline(),
      'picture_src': @model.getPictureSrc(),
      'clients': @model.getClients(),
      'mediums': @model.getMediums(),
      'bg_src': @model.getBgSrc(),
      'poster_src': @model.getPosterSrc(),
      'poster_cta': @model.getPosterCta(),
      'detail_vimeo_id': @model.getDetailVimeoId(),
      'descr_title': @model.getDescrTitle(),
      'descr_text': @model.getDescrText(),
      'services': @model.getServices()
    })))
    @model.getE().append(@model.getV())

    @$title_holder = $('.title-holder', @model.getV())
    @$about_btn = $('.callout.about', @model.getV())
    @$watch_btn = $('.callout.watch', @model.getV())
    @$picture_zone = $('.picture-zone', @model.getV())

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

    @buildVideo('watch', id)
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
  buildVideo: (type, id) =>
    @removeVideos()
    $v = $('<iframe src="//player.vimeo.com/video/' + id + '?title=0&amp;byline=0&amp;portrait=0&amp;color=ffffff&amp;autoplay=1&amp;api=1&amp;player_id=player" id="player" width="960" height="540" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>')
    
    @$video_iframe.empty()
    $(".video-iframe.#{type}", @model.getV()).append($v)
    
    @$player = $f($('#player', @model.getV())[0])
    @$player.addEvent('ready', =>
      if type is 'about'
        @$player.addEvent('finish', @removeVideos)
    )

  ###
  *------------------------------------------*
  | removeVideos:void (=)
  |
  | Remove videos.
  *----------------------------------------###
  removeVideos: =>
    $iframe = $('iframe', @model.getV())

    if $iframe.length > 0
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
    @$title_holder
      .removeClass('trans-in trans-out top bottom')
      .addClass(direction)

    _.defer =>
      @$title_holder
        .addClass('trans-in')
        .removeClass(direction)
      @$picture_zone
        .addClass('show')

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    @$title_holder
      .removeClass('trans-in trans-out top bottom')
      .addClass("#{direction} trans-out")
      .eq(0)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )
    @$picture_zone
      .removeClass('show')

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

module.exports = FeaturedWorkSlideController