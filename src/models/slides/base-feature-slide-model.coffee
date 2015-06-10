###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class BaseFeatureSlideModel extends BaseSlideModel

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

    @_$trans = null
    @_$photo = null

  ###
  *------------------------------------------*
  | get$trans:jQuery (-)
  |
  | Get trans el.
  *----------------------------------------###
  get$trans: ->
    return @_$trans

  ###
  *------------------------------------------*
  | set$trans:jQuery (-)
  |
  | $trans:jQuery - trans el
  |
  | Set trans el.
  *----------------------------------------###
  set$trans: ($trans) ->
    if $trans.length > 0
      @_$trans = $trans
    else
      throw 'ERROR: $trans does not exist'

module.exports = BaseFeatureSlideModel