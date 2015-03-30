###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class WorkDetailController

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
    @model.setV($(JST['work-detail-view']({
      'bg_src': @model.getBgSrc(),
      'title': @model.getTitle(),
      'overview': @model.getOverview(),
      'services': @model.getServices(),
      'accolades': @model.getAccolades(),
      'launch_url': @model.getLaunchUrl()
    })))
    @model.getE().append(@model.getV())

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->

module.exports = WorkDetailController