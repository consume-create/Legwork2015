###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseModel = require './base-model'

class PageModel extends BaseModel

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

    @_id = ''
    @setId(data.id)

  ###
  *------------------------------------------*
  | getId:String (-)
  |
  | Get ID.
  *----------------------------------------###
  getId: ->
    return @_id

  ###
  *------------------------------------------*
  | setId:void (-)
  |
  | id:string - id
  |
  | Set ID.
  *----------------------------------------###
  setId: (id) ->
    @_id = id

module.exports = PageModel