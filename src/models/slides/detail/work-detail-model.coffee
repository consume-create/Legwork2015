###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseModel = require '../../base-model'

class WorkDetailModel extends BaseModel

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

    @_bg_src = null
    @setBgSrc(data.bg_src)

    @_title = null
    @setTitle(data.title)

    @_overview = null
    @setOverview(data.overview)

    @_services = null
    @setServices(data.services)

    @_accolades = null
    @setAccolades(data.accolades)

    @_launch_url = null
    @setLaunchUrl(data.launch_url)

    @_media = null
    @setMedia(data.media)

  ###
  *------------------------------------------*
  | getBgSrc:string (-)
  |
  | Get bg src.
  *----------------------------------------###
  getBgSrc: ->
    return @_bg_src

  ###
  *------------------------------------------*
  | setBgSrc:void (-)
  |
  | bg_src:string - bg src
  |
  | Set bg src.
  *----------------------------------------###
  setBgSrc: (bg_src) ->
    if _.isString(bg_src) is false
      throw 'ERROR: bg_src must be a string'
    else if (/^\/images\//).test(bg_src) is false
      throw 'ERROR: bg_src must be a local reference from the root (e.g. /images/path/to/image.jpg)'
    else
      @_bg_src = bg_src

  ###
  *------------------------------------------*
  | getTitle:string (-)
  |
  | Get title.
  *----------------------------------------###
  getTitle: ->
    return @_title

  ###
  *------------------------------------------*
  | setTitle:void (-)
  |
  | title:string - title
  |
  | Set title.
  *----------------------------------------###
  setTitle: (title) ->
    if _.isString(title) is false
      throw 'ERROR: title must be a string'
    else
      @_title = title

  ###
  *------------------------------------------*
  | getOverview:string (-)
  |
  | Get overview.
  *----------------------------------------###
  getOverview: ->
    return @_overview

  ###
  *------------------------------------------*
  | setOverview:void (-)
  |
  | overview:string - overview
  |
  | Set overview.
  *----------------------------------------###
  setOverview: (overview) ->
    if _.isString(overview) is false
      throw 'ERROR: overview must be a string'
    else
      @_overview = overview

  ###
  *------------------------------------------*
  | getServices:array (-)
  |
  | Get services.
  *----------------------------------------###
  getServices: ->
    return @_services

  ###
  *------------------------------------------*
  | setServices:void (-)
  |
  | services:array - services array
  |
  | Set services.
  *----------------------------------------###
  setServices: (services) ->
    passed = true
    
    if _.isArray(services) is false or (services.length < 1 or services.length > 8)
      passed = false
      throw 'ERROR: services must be an array of at least 1 string, but no more than 8.'
    
    for s in services
      if _.isString(s) is false
        passed = false
        throw 'ERROR: each service must be a string'
        break

    if passed is true
      @_services = services

  ###
  *------------------------------------------*
  | getAccolades:array (-)
  |
  | Get accolades.
  *----------------------------------------###
  getAccolades: ->
    return @_accolades

  ###
  *------------------------------------------*
  | setAccolades:void (-)
  |
  | accolades:array - accolades array
  |
  | Set accolades.
  *----------------------------------------###
  setAccolades: (accolades) ->
    passed = true
    
    if accolades isnt null
      if _.isArray(accolades) is false or (accolades.length < 1 or accolades.length > 8)
        passed = false
        throw 'ERROR: accolades must be an array of at least 1 string, but no more than 8.'
    
      for s in accolades
        if _.isString(s) is false
          passed = false
          throw 'ERROR: each accolade must be a string'
          break

      if passed is true
        @_accolades = accolades

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
  | getMedia:array (-)
  |
  | Get media.
  *----------------------------------------###
  getMedia: ->
    return @_media

  ###
  *------------------------------------------*
  | setMedia:void (-)
  |
  | media:array - media array
  |
  | Set media.
  *----------------------------------------###
  setMedia: (media) ->
    passed = true

    if _.isArray(media) is false
      passed = false
      throw 'ERROR: media must be an array of media objects'

    for m in media
      if _.contains(_.values(LW.media), m.type) is false
        passed = false
        throw 'ERROR: each media type needs to match one of the defined LW.media listed in ./src/env.coffee'
        break
      if m.copy isnt null
        if m.copy.title isnt null and _.isString(m.copy.title) is false
          passed = false
          throw 'ERROR: media copy title must be a string'
          break
        if m.copy.text isnt null and _.isArray(m.copy.text) is false
          passed = false
          throw 'ERROR: media copy text must be an array of strings'
          break
        if m.copy.text isnt null 
          for t in m.copy.text
            if _.isString(t) is false
              passed = false
              throw 'ERROR: each media copy text must be a string'
              break
      if m.type is LW.media.IMAGE
        if _.isArray(m.images) is false
          passed = false
          throw 'ERROR: images must be an array of image paths as strings'
          break
        for img in m.images
          if _.isString(img) is false or (/^\/images\//).test(img) is false
            passed = false
            throw 'ERROR: each img in the images array must be a local reference from the root (e.g. /images/path/to/image.jpg) as a string'
            break
      if m.type is LW.media.VIDEO and _.isString(m.video_id) is false
        passed = false
        throw 'ERROR: video_id must be a string'

    if passed is true
      @_media = media

module.exports = WorkDetailModel