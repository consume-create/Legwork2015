###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class AboutVideoSlideModel extends BaseSlideModel

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

    @_poster_src = null
    @setPosterSrc(data.poster_src)

  ###
  *------------------------------------------*
  | getPosterSrc:string (-)
  |
  | Get poster src.
  *----------------------------------------###
  getPosterSrc: ->
    return @_poster_src

  ###
  *------------------------------------------*
  | setPosterSrc:void (-)
  |
  | poster_src:string - poster src
  |
  | Set poster src.
  *----------------------------------------###
  setPosterSrc: (poster_src) ->
    if _.isString(poster_src) is false
      throw 'ERROR: poster_src must be a string'
    else if (/^\/images\//).test(poster_src) is false
      throw 'ERROR: poster_src must be a local reference from the root (e.g. /images/path/to/image.jpg)'
    else
      @_poster_src = poster_src

module.exports = AboutVideoSlideModel