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

    @$about_btn = $('.callout.about', @model.getV())
    @$line_holder = $('.line-holder', @model.getV())
    @$title = $('.title-holder h2', @model.getV())
    @$picture_zone = $('.picture-zone', @model.getV())
    @$detail_zone = $('.detail-zone', @model.getV())

  ###
  *------------------------------------------*
  | showHideDetailZone:void (=)
  |
  | Show and hide detail zone.
  *----------------------------------------###
  showHideDetailZone: =>
    if @$detail_zone.hasClass('show') is false
      @$detail_zone
        .addClass('show')
      @$about_btn
        .addClass('close')
        .find('.copy').text('Close')
    else
      @$detail_zone
        .removeClass('show')
      @$about_btn
        .removeClass('close')
        .find('.copy').text('About')

  onMouseenterLineHolder: =>
    @$about_btn.addClass('hover')

  onMouseleaveLineHolder: =>
    @$about_btn.removeClass('hover')

  ###
  *------------------------------------------*
  | transitionIn:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition in.
  *----------------------------------------###
  transitionIn: (direction) ->
    @$title
      .removeClass('trans-in trans-out top bottom')
      .addClass(direction)

    _.defer =>
      @$title
        .addClass('trans-in')
        .removeClass(direction)
      @$picture_zone
        .addClass('show')

  ###
  *------------------------------------------*
  | transitionOut:void (-)
  |
  | direction:string - top or bottom
  |
  | Transition out.
  *----------------------------------------###
  transitionOut: (direction, cb) ->
    @$title
      .removeClass('trans-in trans-out top bottom')
      .addClass("#{direction} trans-out")
      .eq(0)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, =>
        cb()
      )
    @$picture_zone
      .removeClass('show')

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    super()
    @$about_btn.removeClass('hover')
    
    @$about_btn
      .off()
      .on('click', @showHideDetailZone)
    @$line_holder
      .off()
      .on('click', @showHideDetailZone)
      .on('mouseenter', @onMouseenterLineHolder)
      .on('mouseleave', @onMouseleaveLineHolder)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    super()

    @$about_btn.off()
    @$line_holder.off()

module.exports = FeaturedWorkSlideController