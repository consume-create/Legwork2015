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

    @_rgb = null
    @setRgb(data.rgb)

  ###
  *------------------------------------------*
  | getRgb:array (-)
  |
  | Get rgb.
  *----------------------------------------###
  getRgb: ->
    return @_rgb

  ###
  *------------------------------------------*
  | setRgb:void (-)
  |
  | rgb:array - rgb array
  |
  | Set rgb.
  *----------------------------------------###
  setRgb: (rgb) ->
    passed = true

    if _.isArray(rgb) is false or rgb.length isnt 3
      passed = false
      throw 'ERROR: rgb must be an array of 3 valid numbers, respectively (r,g,b)'

    for n in rgb
      if _.isNumber(n) is false or (n < 0 or n > 255)
        passed = false
        throw 'ERROR: each rgb value needs to be a number between 0 and 255'
        break

    if passed is true
      @_rgb = rgb

module.exports = BaseSlideModel