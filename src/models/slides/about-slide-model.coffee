###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class AboutSlideModel extends BaseSlideModel

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

    @_instructions = null
    @setInstructions(data.instructions)

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

module.exports = AboutSlideModel