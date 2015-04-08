###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseModel = require './base-model'

class ErrorModel extends BaseModel

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

    @_msg = ''

  ###
  *------------------------------------------*
  | getMsg:String (-)
  |
  | Get message.
  *----------------------------------------###
  getMsg: ->
    return @_msg

  ###
  *------------------------------------------*
  | setMsg:void (-)
  |
  | msg:string - message
  |
  | Set message.
  *----------------------------------------###
  setMsg: (msg) ->
    @_msg = msg

module.exports = ErrorModel