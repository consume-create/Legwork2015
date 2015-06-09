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

  ###
  *------------------------------------------*
  | getPhotoEl:jQuery (-)
  |
  | Get photo el.
  *----------------------------------------###
  get$photo: ->
    return @_$photo

  ###
  *------------------------------------------*
  | setPhotoEl:jQuery (-)
  |
  | $photo:jQuery - photo el
  |
  | Set photo el.
  *----------------------------------------###
  set$photo: ($photo) ->
    if $photo.length > 0
      @_$photo = $photo
    else
      throw 'ERROR: $photo does not exist'


module.exports = BaseFeatureSlideModel