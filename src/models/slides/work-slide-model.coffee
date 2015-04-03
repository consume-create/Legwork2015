###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class WorkSlideModel extends BaseSlideModel

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

    @_title = null
    @setTitle(data.title)

    @_reel_video_id = null
    @setReelVideoId(data.reel_video_id)

    @_instructions = null
    @setInstructions(data.instructions)

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
  | getTitle:array (-)
  |
  | Get title.
  *----------------------------------------###
  getTitle: ->
    return @_title

  ###
  *------------------------------------------*
  | setTitle:void (-)
  |
  | title:array - title array
  |
  | Set title.
  *----------------------------------------###
  setTitle: (title) ->
    max = 20

    if _.isArray(title) is false or title.length isnt 2
      throw 'ERROR: title must be an array of 2 strings'
    else if title[0].length > max or title[1].length > max
      throw 'ERROR: title parts must be ' + max + ' characters or less'
    else
      @_title = title

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
  | getInstructions:string (-)
  |
  | Get instructions.
  *----------------------------------------###
  getInstructions: ->
    return @_instructions

  ###
  *------------------------------------------*
  | setInstructions:void (-)
  |
  | instructions:string - instructions
  |
  | Set instructions.
  *----------------------------------------###
  setInstructions: (instructions) ->
    if _.isString(instructions) is false
      throw 'ERROR: instructions must be a string'
    else
      @_instructions = instructions

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

module.exports = WorkSlideModel