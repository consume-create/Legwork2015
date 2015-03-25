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

    @_id = null
    @setId(data.id)

    @_title = null
    @setTitle(data.title)

    @_picture_src = null
    @setPictureSrc(data.picture_src)

    @_copy = null
    @setCopy(data.copy)

    @_lists = null
    @setLists(data.lists)

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

  ###
  *------------------------------------------*
  | getCopy:string (-)
  |
  | Get copy.
  *----------------------------------------###
  getCopy: ->
    return @_copy

  ###
  *------------------------------------------*
  | setCopy:void (-)
  |
  | copy:string - copy
  |
  | Set copy.
  *----------------------------------------###
  setCopy: (copy) ->
    if copy isnt null and _.isString(copy) is false
      throw 'ERROR: copy must be a string'
    else
      @_copy = copy

  ###
  *------------------------------------------*
  | getLists:string (-)
  |
  | Get lists.
  *----------------------------------------###
  getLists: ->
    return @_lists

  ###
  *------------------------------------------*
  | setLists:void (-)
  |
  | lists:array - lists
  |
  | Set lists.
  *----------------------------------------###
  setLists: (lists) ->
    if _.isArray(lists) is false
      throw 'ERROR: lists must be an array of lists'
    else
      @_lists = lists

module.exports = AboutProcessSlideModel