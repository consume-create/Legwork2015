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

    @_messages = null
    @setMessages(data.messages)

  ###
  *------------------------------------------*
  | getMessages:array (-)
  |
  | Get messages.
  *----------------------------------------###
  getMessages: ->
    return @_messages

  ###
  *------------------------------------------*
  | setMessages:void (-)
  |
  | messages:array - messages array
  |
  | Set messages.
  *----------------------------------------###
  setMessages: (messages) ->
    passed = true

    if _.isArray(messages) is false
      passed = false
      throw 'ERROR: messages must be an array of strings'

    for m in messages
      if _.isString(m) is false
        passed = false
        throw 'ERROR: each message needs to be a string'
        break

    if passed is true
      @_messages = messages

module.exports = ErrorModel