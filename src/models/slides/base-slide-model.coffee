###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# NOTE:
# To add a new slide type, you must:
# 1. Define a const slide type in ./env
# 2. Add a data file to ./data/* where you would like to use the slide
# 3. Add the slide model, view and controller (extend the base model and controller classes)
# 4. Require the model and controller in the page controller and add a condition to the build method

# Dependencies
BaseModel = require '../base-model'

class BaseSlideModel extends BaseModel

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

    @_type = null
    @setType(data.type)

  ###
  *------------------------------------------*
  | getType:string (-)
  |
  | Get type.
  *----------------------------------------###
  getType: ->
    return @_type

  ###
  *------------------------------------------*
  | setType:void (-)
  |
  | type:string - type
  |
  | Set type.
  *----------------------------------------###
  setType: (type) ->
    if _.isString(type) is false
      throw 'ERROR: type must be a string'
    else
      @_type = type

module.exports = BaseSlideModel