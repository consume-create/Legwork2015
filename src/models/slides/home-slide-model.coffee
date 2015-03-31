###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class HomeSlideModel extends BaseSlideModel

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

    @_instructions = null
    @setInstructions(data.instructions)

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

module.exports = HomeSlideModel