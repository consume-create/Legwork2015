###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class SlideshowController

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
    @model.setV($(JST['slideshow-view']({
      'images': @model.getImages()
    })))
    @model.getE().append(@model.getV())

    @$slider = $('.slider', @model.getV())
    @$slide = $('.slide', @model.getV())
    @$arrow = $('.arrow', @model.getV())
    
    @active_index = 0
    @total_slides = @$slide.length

  ###
  *------------------------------------------*
  | onClickArrow:void (-)
  |
  | e:object - event object
  |
  | Click arrow.
  *----------------------------------------###
  onClickArrow: (e) =>
    if $(e.currentTarget).hasClass('prev')
      @previous()
    else
      @next()

  ###
  *------------------------------------------*
  | previous:void (=)
  |
  | Previous slide, if there is one.
  *----------------------------------------###
  previous: =>
    if @active_index > 0
      @active_index--
      @updateSlider()

  ###
  *------------------------------------------*
  | next:void (=)
  |
  | Next slide, if there is one.
  *----------------------------------------###
  next: =>
    if @active_index < (@total_slides - 1)
      @active_index++
      @updateSlider()

  ###
  *------------------------------------------*
  | updateShoe:void (=)
  |
  | Update shoe.
  *----------------------------------------###
  updateSlider: =>
    @updateArrows()
    x = -(@active_index * 100) + '%'

    obj_x = {}
    obj_x[LW.utils.transform] = LW.utils.translate("#{x}", 0)
    @$slider.css(obj_x)

  ###
  *------------------------------------------*
  | updateArrows:void (=)
  |
  | Update arrows.
  *----------------------------------------###
  updateArrows: =>
    @$arrow.removeClass('disabled')

    if @active_index is 0
      @$arrow.eq(0).addClass('disabled')
    else if @active_index is (@total_slides - 1)
      @$arrow.eq(1).addClass('disabled')

  reset: ->
    @active_index = 0
    @updateSlider()

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @reset()
    @$arrow
      .off('click')
      .on('click', @onClickArrow)

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Suspend.
  *----------------------------------------###
  suspend: ->
    @$arrow.off('click')

module.exports = SlideshowController