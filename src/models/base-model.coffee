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
    @_$el = null
    @_$view = null

    @setE(data.$el)

  ###
  *------------------------------------------*
  | getE:jQuery (-)
  |
  | Get element.
  *----------------------------------------###
  getE: ->
    return @_$el

  ###
  *------------------------------------------*
  | setE:void (-)
  |
  | $el:jQuery - element
  |
  | Set element.
  *----------------------------------------###
  setE: ($el) ->
    if $el.length > 0
      @_$el = $el
    else
      throw 'ERROR: $el does not exist'

  ###
  *------------------------------------------*
  | getV:jQuery (-)
  |
  | Get view.
  *----------------------------------------###
  getV: ->
    return @_$view

  ###
  *------------------------------------------*
  | setV:void (-)
  |
  | $view:jQuery - element
  |
  | Set view.
  *----------------------------------------###
  setV: ($view) ->
    if $view.length > 0
      @_$view = $view
    else
      throw 'ERROR: $view does not exist'

module.exports = BaseModel