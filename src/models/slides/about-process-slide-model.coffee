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
    @setName(data.name)

  ###
  *------------------------------------------*
  | getName:string (-)
  |
  | Get name.
  *----------------------------------------###
  getName: ->
    return @_launch_url

  ###
  *------------------------------------------*
  | setName:void (-)
  |
  | name:string - name
  |
  | Set name.
  *----------------------------------------###
  setName: (name) ->
    console.log name
    if _.isString(name) is false
      throw 'ERROR: name must be a string'
    else
      @_name = name

module.exports = AboutProcessSlideModel