###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class FeaturedWorkSlideModel extends BaseSlideModel

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

    @_title = null
    @setTitle(data.title)

    @_callouts = null
    @setCallouts(data.callouts)

    @_launch_url = null
    @setLaunchUrl(data.launch_url)

    @_watch_video_id = null
    @setWatchVideoId(data.watch_video_id)

    @_details_url = null
    @setDetailsUrl(data.details_url)

    @_watch_url = null
    @setWatchUrl(data.watch_url)

    @_picture_src = null
    @setPictureSrc(data.picture_src)

    @_clients = null
    @setClients(data.clients)

    @_mediums = null
    @setMediums(data.mediums)

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
    if _.isArray(title) is false or title.length isnt 2
      throw 'ERROR: title must be an array of 2 strings'
    else if title[0].length > LW.TITLE_MAX or title[1].length > LW.TITLE_MAX
      throw 'ERROR: title parts must be ' + LW.TITLE_MAX + ' characters or less'
    else
      @_title = title

  ###
  *------------------------------------------*
  | getCallouts:array (-)
  |
  | Get callouts.
  *----------------------------------------###
  getCallouts: ->
    return @_callouts

  ###
  *------------------------------------------*
  | setCallouts:void (-)
  |
  | callouts:array - callouts array
  |
  | Set callouts.
  *----------------------------------------###
  setCallouts: (callouts) ->
    passed = true

    if _.isArray(callouts) is false or (callouts.length < 1 or callouts.length > 3)
      passed = false
      throw 'ERROR: callouts must be an array of at least 1, but no more than 3 of the defined LW.callouts listed in ./src/env.coffee'

    for m in callouts
      if _.contains(_.values(LW.callouts), m) is false
        passed = false
        throw 'ERROR: each callout needs to match one of the defined LW.callouts listed in ./src/env.coffee'
        break

    if passed is true
      @_callouts = callouts

  ###
  *------------------------------------------*
  | getLaunchUrl:string (-)
  |
  | Get launch url.
  *----------------------------------------###
  getLaunchUrl: ->
    return @_launch_url

  ###
  *------------------------------------------*
  | setLaunchUrl:void (-)
  |
  | launch_url:string - launch url
  |
  | Set launch url.
  *----------------------------------------###
  setLaunchUrl: (launch_url) ->
    if launch_url isnt null and _.isString(launch_url) is false
      throw 'ERROR: launch_url must be a string'
    else
      @_launch_url = launch_url

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

  ###
  *------------------------------------------*
  | getDetailsUrl:string (-)
  |
  | Get details url.
  *----------------------------------------###
  getDetailsUrl: ->
    return @_details_url

  ###
  *------------------------------------------*
  | setDetailsUrl:void (-)
  |
  | details_url:string - details url
  |
  | Set details url.
  *----------------------------------------###
  setDetailsUrl: (details_url) ->
    if details_url isnt null and _.isString(details_url) is false
      throw 'ERROR: details_url must be a string'
    else
      @_details_url = details_url

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

  ###
  *------------------------------------------*
  | getPictureSrc:string (-)
  |
  | Get picture src.
  *----------------------------------------###
  getPictureSrc: ->
    return @_picture_src

  ###
  *------------------------------------------*
  | setPictureSrc:void (-)
  |
  | picture_src:string - picture src
  |
  | Set picture src.
  *----------------------------------------###
  setPictureSrc: (picture_src) ->
    if _.isString(picture_src) is false
      throw 'ERROR: picture_src must be a string'
    else if (/^\/images\//).test(picture_src) is false
      throw 'ERROR: picture_src must be a local reference from the root (e.g. /images/path/to/image.jpg)'
    else
      @_picture_src = picture_src

  ###
  *------------------------------------------*
  | getClients:array (-)
  |
  | Get clients.
  *----------------------------------------###
  getClients: ->
    return @_clients

  ###
  *------------------------------------------*
  | setClients:void (-)
  |
  | clients:array - clients array
  |
  | Set clients logos.
  *----------------------------------------###
  setClients: (clients) ->
    passed = true

    if _.isArray(clients) is false or (clients.length < 1 or clients.length > 3)
      passed = false
      throw 'ERROR: clients must be an array of at least 1 string, but no more than 3'

    for c in clients
      if (/^\/images\/client\-logos\//).test(c) is false
        passed = false
        throw 'ERROR: clients must be referenced from the root at /images/client-logos/...'
        break

    if passed is true
      @_clients = clients

  ###
  *------------------------------------------*
  | getMediums:array (-)
  |
  | Get mediums.
  *----------------------------------------###
  getMediums: ->
    return @_mediums

  ###
  *------------------------------------------*
  | setMediums:void (-)
  |
  | mediums:array - mediums array
  |
  | Set mediums.
  *----------------------------------------###
  setMediums: (mediums) ->
    passed = true

    if _.isArray(mediums) is false or (mediums.length < 1 or mediums.length > 3)
      passed = false
      throw 'ERROR: mediums must be an array of at least 1, but no more than 3 of the defined LW.mediums listed in ./src/env.coffee'

    for m in mediums
      if _.contains(_.values(LW.mediums), m) is false
        passed = false
        throw 'ERROR: each medium needs to match one of the defined LW.mediums listed in ./src/env.coffee'
        break

    if passed is true
      @_mediums = mediums

module.exports = FeaturedWorkSlideModel