###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class WatchVideoController

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
    @model.setV($(JST['watch-video-view']()))
    @model.getE().append(@model.getV())

    @$video_holder = $('.video-holder', @model.getV())
    @$video_player = $('.video-player', @model.getV())
    @$loader = $('.watch-video-loader', @model.getV())

  ###
  *------------------------------------------*
  | loadVideo:void (=)
  |
  | Load video.
  *----------------------------------------###
  loadVideo: =>
    @$loader.addClass('loading')

    @$loader[0].offsetHeight
    @$loader
      .addClass('loaded')
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        @setVideo()
        @$loader.removeClass('loading')
      )

  ###
  *------------------------------------------*
  | setVideo:void (-)
  |
  | Set video.
  *----------------------------------------###
  setVideo: ->
    id = @model.getWatchVideoId()
    $.getJSON("https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/#{id}", (data) =>
      r = (data.height / data.width) * 100
      @$video_player.css('padding-bottom', r + '%')
    )

    $v = "<iframe src='//player.vimeo.com/video/#{id}?title=0&amp;byline=0&amp;badge=0&amp;portrait=0&amp;color=fff&amp;autoplay=1&amp;player_id=player' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
    @$video_player.append($v).addClass('playing')

  ###
  *------------------------------------------*
  | reset:void (-)
  |
  | Reset.
  *----------------------------------------###
  reset: ->
    @$video_player.empty()
    @$loader.removeClass('loading loaded')

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @model.getE().show()
    @loadVideo()

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    @model.getE().hide()

module.exports = WatchVideoController