###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseModel = require '../../base-model'

class SlideshowModel extends BaseModel

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

    @_images = null
    @setImages(data.images)

  ###
  *------------------------------------------*
  | getImages:string (-)
  |
  | Get images.
  *----------------------------------------###
  getImages: ->
    return @_images

  ###
  *------------------------------------------*
  | setImages:void (-)
  |
  | images:array - images array
  |
  | Set images.
  *----------------------------------------###
  setImages: (images) ->
    passed = true
    
    if _.isArray(images) is false
      passed = false
      throw 'ERROR: images must be an array of strings'
    
    for img in images
      if _.isString(img) is false
        passed = false
        throw 'ERROR: each img must be a string'
        break
      if (/^\/images\//).test(img) is false
        throw 'ERROR: img must be a local reference from the root (e.g. /images/path/to/image.jpg)'
        break

    if passed is true
      @_images = images

module.exports = SlideshowModel