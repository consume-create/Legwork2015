###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class BaseModel

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | data:object - data
  |
  | Construct.
  *----------------------------------------###
  constructor: (data) ->
    @$el = null
    @$view = null

    @setE(data.$el)

  getE: ->
    return @$el

  setE: ($el) ->
    if $el.length > 0
      @$el = $el
    else
      throw 'ERROR: $el does not exist'

  getV: ->
    return @$view

  setV: ($view) ->
    if $view.length > 0
      @$view = $view
    else
      throw 'ERROR: $view does not exist'

module.exports = BaseModel