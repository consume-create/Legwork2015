###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class AboutProcessSlideModel extends BaseSlideModel

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

    @_picture_src = null
    @setPictureSrc(data.picture_src)

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

module.exports = AboutProcessSlideModel