###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseModel = require './base-model'

class PageModel extends BaseModel

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

    @_id = ''
    @setId(data.id)

    @_slide_data = null
    @setSlideData(data.slides)

    @_color_index = null
    @setColorIndex(data.color_index)

  ###
  *------------------------------------------*
  | getId:String (-)
  |
  | Get ID.
  *----------------------------------------###
  getId: ->
    return @_id

  ###
  *------------------------------------------*
  | setId:void (-)
  |
  | id:string - id
  |
  | Set ID.
  *----------------------------------------###
  setId: (id) ->
    @_id = id

  ###
  *------------------------------------------*
  | getSlideData:Object (-)
  |
  | Get slide data.
  *----------------------------------------###
  getSlideData: ->
    return @_slide_data

  ###
  *------------------------------------------*
  | setColorIndex:void (-)
  |
  | data:object - data
  |
  | Set slide data.
  *----------------------------------------###
  setSlideData: (data) ->
    @_slide_data = data

  ###
  *------------------------------------------*
  | getColorIndex:number (-)
  |
  | Get color index.
  *----------------------------------------###
  getColorIndex: ->
    return @_color_index

  ###
  *------------------------------------------*
  | setColorIndex:void (-)
  |
  | color_index:number - color index
  |
  | Set color index.
  *----------------------------------------###
  setColorIndex: (color_index) ->
    if _.isNumber(color_index) is false
      throw 'ERROR: color_index must be a number'
    else if color_index < 0 or color_index > LW.colors.length - 1
      throw 'ERROR: color_index must be greater than 0 and no higher than the number of colors in the defined LW.colors, listed in ./src/env.coffee'
    else
      @_color_index = color_index

module.exports = PageModel