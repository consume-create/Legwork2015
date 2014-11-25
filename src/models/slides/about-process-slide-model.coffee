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

    @_name = null
    @setTitle(data.title)

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

module.exports = AboutProcessSlideModel