###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Slideshow
SlideshowModel = require '../../../models/slides/detail/slideshow-model'
SlideshowController = require './slideshow-controller'

class WorkDetailController

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
    @slideshow_m = null
    @slideshow_c = null

    @build()

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    @model.setV($(JST['work-detail-view']({
      'bg_src': @model.getBgSrc(),
      'title': @model.getTitle(),
      'overview': @model.getOverview(),
      'services': @model.getServices(),
      'accolades': @model.getAccolades(),
      'launch_url': @model.getLaunchUrl(),
      'media': @model.getMedia()
    })))
    @model.getE().append(@model.getV())

    # Cache selectors
    @$content = $('.content', @model.getV())
    @$black_box = $('.black-box', @model.getV())
    @$bg = $('.bg', @model.getV())
    @src = @$bg.attr('data-src')
    @$media_slideshow = $('.media-slideshow', @model.getV())
    @$video_holder = $('.video-holder', @model.getV())
    @$video_poster = $('.video-poster', @model.getV())
    @$video_player = $('.video-player', @model.getV())

    # Build slideshow
    @slideshow_exists = false
    if @$media_slideshow.length > 0
      @slideshow_exists = true

      @slideshow_m = new SlideshowModel({
        '$el': $('.inner', @$media_slideshow),
        'images': _.findWhere(@model.getMedia(), {type: LW.media.SLIDESHOW}).images
      })
      @slideshow_c = new SlideshowController({
        'model': @slideshow_m
      })

    # Build videos
    @videos_exist = false
    if @$video_holder.length > 0
      @videos_exist = true

  ###
  *------------------------------------------*
  | loadDetailTransition:void (=)
  |
  | Load detail and transition black box.
  *----------------------------------------###
  loadDetailTransition: =>
    $loader = $('.detail-loader', @model.getV())
    @$black_box.removeClass('slide-up')
    @$content.scrollTop(0)
    @model.getE()[0].offsetHeight # Reflow like a a defer

    if $loader.length > 0
      $loader.addClass('loading')
      $current = $('<img />').attr
        'src': @src
      .one 'load', (e) =>
        @$bg.attr('style': "background-image: url(#{@src})")
        $loader
          .addClass('loaded')
          .off()
          .one(LW.utils.transition_end, =>
            @$black_box.addClass('slide-up')
            $loader.removeClass('loading').remove()
          )

      if $current[0].complete is true
        $current.trigger('load')

      return $current[0]
    else
      @$black_box.addClass('slide-up')

  ###
  *------------------------------------------*
  | buildVideos:void (-)
  |
  | Build video(s).
  *----------------------------------------###
  buildVideos: ->
    _.each(@$video_holder, (el, i) =>
      $t = $(el)
      $poster = $('.video-poster', $t)
      id = $poster.attr('data-id')

      # $.getJSON("https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/#{$t.attr('data-id')}")
      $.getJSON("https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/#{id}", (data) =>
        r = (data.height / data.width) * 100
        $t.css('padding-bottom', r + '%')
        $poster.attr('style', "background-image: url('#{data.thumbnail_url}');")
      )
    )

  ###
  *------------------------------------------*
  | onClickPoster:void (=)
  |
  | Click poster, hide, append video.
  *----------------------------------------###
  onClickPoster: (e) =>
    @resetVideos()
    
    $t = $(e.currentTarget)
    $v = "<iframe src='//player.vimeo.com/video/#{$t.attr('data-id')}?title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1&amp;api=1&amp;player_id=player' id='player' width='720' height='405' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
    
    $t[0].offsetHeight
    $t.parent('.video-holder').addClass('playing')
    $t.siblings('.video-player').append($v)
    $froogavid = $f($('#player', @model.getV())[0])

    $froogavid.addEvent('ready', =>
      $froogavid.addEvent('finish', @endVideo)
    )

  ###
  *------------------------------------------*
  | endVideo:void (=)
  |
  | End video.
  *----------------------------------------###
  endVideo: =>
    @resetVideos()

  ###
  *------------------------------------------*
  | resetVideos:void (=)
  |
  | Reset videos.
  *----------------------------------------###
  resetVideos: =>
    @$video_holder.removeClass('playing')
    @$video_player.empty()

  ###
  *------------------------------------------*
  | turnOffDetails:void (=)
  |
  | Turn off details slideshow, videos, etc.
  *----------------------------------------###
  turnOffDetails: =>
    console.log 'turn work detail components off'
    

  ###
  *------------------------------------------*
  | turnDetailHandlers:void (-)
  |
  | s:string - on / off
  |
  | Turn detail event handlers on / off.
  *----------------------------------------###
  turnDetailHandlers: (s) =>
    if @slideshow_exists is true
      @slideshow_c.suspend()

    if @videos_exist is true
      @resetVideos()
      @$video_poster.off('click')

    if s is 'on'
      if @slideshow_exists is true
        @slideshow_c.activate()

      if @videos_exist is true
        @buildVideos()
        @$video_poster.on('click', @onClickPoster)

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @model.getE().addClass('active')
    @loadDetailTransition()

    @turnDetailHandlers('on')

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    @model.getE().removeClass('active')

module.exports = WorkDetailController