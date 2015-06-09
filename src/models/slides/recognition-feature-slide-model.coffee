###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
HomeFeatureSlideModel = require './home-feature-slide-model'

class RecognitionFeatureSlideModel extends HomeFeatureSlideModel

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

    @_awards = null
    @setAwards(data.awards)

  ###
  *------------------------------------------*
  | getAwards:object (-)
  |
  | Get awards.
  *----------------------------------------###
  getAwards: ->
    return @_awards

  ###
  *------------------------------------------*
  | setAwards:void (-)
  |
  | awards:object - awards
  |
  | Set awards.
  *----------------------------------------###
  setAwards: (awards) ->
    if _.isObject(awards) is false
      throw 'ERROR: awards must be an object'
    else
      @_awards = awards

module.exports = RecognitionFeatureSlideModel