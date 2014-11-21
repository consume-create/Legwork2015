###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

BaseSlideController = require './base-slide-controller'

class FeaturedWorkSlideController extends BaseSlideController

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
    super()
    @model.setV($(JST['featured-work-slide-view']({
      'title': @model.getTitle(),
      'callouts': @model.getCallouts(),
      'launch_url': @model.getLaunchUrl(),
      'picture_src': @model.getPictureSrc(),
      'clients': @model.getClients(),
      'mediums': @model.getMediums(),
      'poster_src': @model.getPosterSrc(),
      'poster_cta': @model.getPosterCta(),
      'vimeo_id': @model.getVimeoId(),
      'descr_title': @model.getDescrTitle(),
      'descr_text': @model.getDescrText(),
      'services': @model.getServices()
    })))
    @model.getE().append(@model.getV())

    @$detail_zone = $('.detail-zone', @model.getV())
    @$about_btn = $('.callout.about', @model.getV())

    @observeSomeSweetEvents()

  ###
  *------------------------------------------*
  | observeSomeSweetEvents:void (-)
  |
  | Observe some sweet events.
  *----------------------------------------###
  observeSomeSweetEvents: ->
    @$about_btn.on('click', @showHideDetailZone)

  ###
  *------------------------------------------*
  | showHideDetailZone:void (=)
  |
  | Show and hide detail zone.
  *----------------------------------------###
  showHideDetailZone: =>
    if @$detail_zone.is(':hidden')
      @$detail_zone.show()
      @$about_btn.find('.copy').text('Close')
    else
      @$detail_zone.hide()
      @$about_btn.find('.copy').text('About')

module.exports = FeaturedWorkSlideController