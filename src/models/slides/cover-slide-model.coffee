###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class CoverSlideModel extends BaseSlideModel

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | data:object - data
  |
  | Construct.
  *----------------------------------------###
  constructor: (data) ->
    super(data)

    @_id = null
    @setId(data.id)

    @_base_video_path = null
    @setBaseVideoPath(data.base_video_path)

    @_reel_video_id = null
    @setReelVideoId(data.reel_video_id)

    @_watch_url = null
    @setWatchUrl(data.watch_url)

  ###
  *------------------------------------------*
  | getId:string (-)
  |
  | Get id.
  *----------------------------------------###
  getId: ->
    return @_id

  ###
  *------------------------------------------*
  | setId:void (-)
  |
  | id:string - id
  |
  | Set id.
  *----------------------------------------###
  setId: (id) ->
    if _.isString(id) is false
      throw 'ERROR: id must be a string'
    else
      @_id = id

  ###
  *------------------------------------------*
  | getBaseVideoPath:string (-)
  |
  | Get base video path.
  *----------------------------------------###
  getBaseVideoPath: ->
    return @_base_video_path

  ###
  *------------------------------------------*
  | setBaseVideoPath:void (-)
  |
  | path:string - path
  |
  | Set base video path.
  *----------------------------------------###
  setBaseVideoPath: (path) ->
    if _.isString(path) is false
      throw 'ERROR: path must be a string'
    else
      @_base_video_path = path

  ###
  *------------------------------------------*
  | getReelVideoId:string (-)
  |
  | Get reel video id.
  *----------------------------------------###
  getReelVideoId: ->
    return @_reel_video_id

  ###
  *------------------------------------------*
  | setReelVideoId:void (-)
  |
  | reel_video_id:string - vimeo id
  |
  | Set reel video id.
  *----------------------------------------###
  setReelVideoId: (reel_video_id) ->
    if reel_video_id isnt null and _.isString(reel_video_id) is false
      throw 'ERROR: reel_video_id must be a string'
    else
      @_reel_video_id = reel_video_id

  ###
  *------------------------------------------*
  | getWatchUrl:string (-)
  |
  | Get watch url.
  *----------------------------------------###
  getWatchUrl: ->
    return @_watch_url

  ###
  *------------------------------------------*
  | setWatchUrl:void (-)
  |
  | watch_url:string - watch url
  |
  | Set watch url.
  *----------------------------------------###
  setWatchUrl: (watch_url) ->
    if watch_url isnt null and _.isString(watch_url) is false
      throw 'ERROR: watch_url must be a string'
    else
      @_watch_url = watch_url

module.exports = CoverSlideModel