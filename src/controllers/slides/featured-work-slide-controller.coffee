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
    super(init)

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
      'rgb': @model.getRgb(),
      'callouts': @model.getCallouts(),
      'launch_url': @model.getLaunchUrl(),
      'tagline': @model.getTagline(),
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
    @$title = $('.title-holder h2', @model.getV())

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

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (pos_in) ->
    obj = {}
    obj[LW.utils.transform] = LW.utils.translate(0, (pos_in * 100) + '%')
    @$title
      .addClass('no-trans')
      .css(obj)

    _.defer =>
      obj[LW.utils.transform] = LW.utils.translate(0, 0 + '%')
      @$title
        .removeClass('no-trans')
        .css(obj)

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (pos_out, cb) ->
    obj = {}
    obj[LW.utils.transform] = LW.utils.translate(0, (pos_out * 100) + '%')
    @$title
      .css(obj)
      .eq(0)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    super()

    @$about_btn.off().on('click', @showHideDetailZone)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    super()

    @$about_btn.off()

module.exports = FeaturedWorkSlideController