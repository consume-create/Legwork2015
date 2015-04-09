###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class ErrorController

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | init:object - init object
  |
  | Construct.
  *----------------------------------------###
  constructor: (init) ->
    @model = init.model
    @build()

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    @model.setV($(JST['error-view']({
      "messages": @model.getMessages()
    })))
    @model.getE().append(@model.getV())

    @$msg = $('#error-msg', @model.getV())

  ###
  *------------------------------------------*
  | randomMessage:void (-)
  |
  | Random message.
  *----------------------------------------###
  randomMessage: ->
    msgs = @model.getMessages().length - 1
    n = _.random(0, msgs)
    
    @$msg.text(@model.getMessages()[n])

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @randomMessage()
    @model.getE().show()

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    @model.getE().hide()

module.exports = ErrorController