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

    @_$title = null
    @_$photo = null

  ###
  *------------------------------------------*
  | getTitleEl:jQuery (-)
  |
  | Get title el.
  *----------------------------------------###
  get$title: ->
    return @_$title

  ###
  *------------------------------------------*
  | setTitleEl:jQuery (-)
  |
  | $title:jQuery - title el
  |
  | Set title el.
  *----------------------------------------###
  set$title: ($title) ->
    if $title.length > 0
      @_$title = $title
    else
      throw 'ERROR: $title does not exist'

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