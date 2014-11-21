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

    @_picture_src = null
    @setPictureSrc(data.picture_src)

    @_clients = null
    @setClients(data.clients)

    @_mediums = null
    @setMediums(data.mediums)

    # Details
    @_poster_src = null
    @setPosterSrc(data.poster_src)

    @_poster_cta = null
    @setPosterCta(data.poster_cta)

    @_vimeo_id = null
    @setVimeoId(data.vimeo_id)

    @_descr_title = null
    @setDescrTitle(data.descr_title)

    @_descr_text = null
    @setDescrText(data.descr_text)

    @_services = null
    @setServices(data.services)

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
    else if title[0].length > 13 or title[1].length > 13
      throw 'ERROR: title parts must be 13 characters or less'
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

    if _.isArray(callouts) is false or callouts.length isnt 2
      passed = false
      throw 'ERROR: callouts must be an array of 2 of the defined LW.callouts listed in ./src/env.coffee'

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
    console.log 'launch_url:', launch_url
    if _.isString(launch_url) is false
      throw 'ERROR: launch_url must be a string'
    else
      @_launch_url = launch_url

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

  ###
  *------------------------------------------*
  | getPosterSrc:string (-)
  |
  | Get poster src.
  *----------------------------------------###
  getPosterSrc: ->
    return @_poster_src

  ###
  *------------------------------------------*
  | setPosterSrc:void (-)
  |
  | poster_src:string - poster src
  |
  | Set poster src.
  *----------------------------------------###
  setPosterSrc: (poster_src) ->
    if _.isString(poster_src) is false
      throw 'ERROR: poster_src must be a string'
    else if (/^\/images\//).test(poster_src) is false
      throw 'ERROR: poster_src must be a local reference from the root (e.g. /images/path/to/image.jpg)'
    else
      @_poster_src = poster_src

  ###
  *------------------------------------------*
  | getPosterCta:string (-)
  |
  | Get poster cta.
  *----------------------------------------###
  getPosterCta: ->
    return @_poster_cta

  ###
  *------------------------------------------*
  | setPosterCta:void (-)
  |
  | poster_cta:string - poster cta
  |
  | Set poster src.
  *----------------------------------------###
  setPosterCta: (poster_cta) ->
    if _.isString(poster_cta) is false
      throw 'ERROR: poster_cta must be a string'
    else
      @_poster_cta = poster_cta

  ###
  *------------------------------------------*
  | getVimeoId:string (-)
  |
  | Get vimeo id.
  *----------------------------------------###
  getVimeoId: ->
    return @_vimeo_id

  ###
  *------------------------------------------*
  | setVimeoId:void (-)
  |
  | vimeo_id:string - vimeo id
  |
  | Set vimeo id.
  *----------------------------------------###
  setVimeoId: (vimeo_id) ->
    if _.isString(vimeo_id) is false
      throw 'ERROR: vimeo_id must be a string'
    else
      @_vimeo_id = vimeo_id

  ###
  *------------------------------------------*
  | getDescrTitle:string (-)
  |
  | Get descr title.
  *----------------------------------------###
  getDescrTitle: ->
    return @_descr_title

  ###
  *------------------------------------------*
  | setDescrTitle:void (-)
  |
  | descr_title:string - descr title
  |
  | Set descr title.
  *----------------------------------------###
  setDescrTitle: (descr_title) ->
    if _.isString(descr_title) is false
      throw 'ERROR: descr_title must be a string'
    else
      @_descr_title = descr_title

  ###
  *------------------------------------------*
  | getDescrText:string (-)
  |
  | Get descr text.
  *----------------------------------------###
  getDescrText: ->
    return @_descr_text

  ###
  *------------------------------------------*
  | setDescrText:void (-)
  |
  | descr_text:string - descr text
  |
  | Set descr text.
  *----------------------------------------###
  setDescrText: (descr_text) ->
    if _.isString(descr_text) is false or descr_text.length > 250
      throw 'ERROR: descr_text must be a string and no more than 250 characters'
    else
      @_descr_text = descr_text

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
    
    if _.isArray(services) is false or (services.length < 1 or services.length > 5)
      passed = false
      throw 'ERROR: services must be an array of at least 1 string, but no more than 5'
    
    for s in services
      if _.isString(s) is false
        passed = false
        throw 'ERROR: each service must be a string'
        break

    if passed is true
      @_services = services

module.exports = FeaturedWorkSlideModel