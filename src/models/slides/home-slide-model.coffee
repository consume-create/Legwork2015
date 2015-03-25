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

module.exports = HomeSlideModel