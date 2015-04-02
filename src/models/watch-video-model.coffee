###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseModel = require './base-model'

class WatchVideoModel extends BaseModel

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

    @_watch_video_id = null

  ###
  *------------------------------------------*
  | getWatchVideoId:string (-)
  |
  | Get watch video id.
  *----------------------------------------###
  getWatchVideoId: ->
    return @_watch_video_id

  ###
  *------------------------------------------*
  | setWatchVideoId:void (-)
  |
  | watch_video_id:string - vimeo id
  |
  | Set watch video id.
  *----------------------------------------###
  setWatchVideoId: (watch_video_id) ->
    if watch_video_id isnt null and _.isString(watch_video_id) is false
      throw 'ERROR: watch_video_id must be a string'
    else
      @_watch_video_id = watch_video_id

module.exports = WatchVideoModel