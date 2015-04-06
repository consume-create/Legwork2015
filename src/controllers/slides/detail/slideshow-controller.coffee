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

    # Cache selectors
    @$slider = $('.slider', @model.getV())
    @$initial_slide = $('.slide', @model.getV())
    @$arrow = $('.arrow', @model.getV())

    # Draggable vars
    @resistance = 1
    @dragging = false
    @drag_time = 666
    @trans_x = 0
    @start_time = 0
    @start_x = 0
    @current_x = 0
    @range = 30
    @current_range = 0
    @now = 0
    @drag_obj = {}

    @mousedown = if Modernizr.touch then "touchstart" else "mousedown"
    @mousemove = if Modernizr.touch then "touchmove" else "mousemove"
    @mouseup = if Modernizr.touch then "touchend" else "mouseup"

    # Clone to initial slides and store these selecotrs/vars
    @$initial_slide.eq(-1).clone().prependTo(@$slider)
    @$initial_slide.eq(0).clone().appendTo(@$slider)
    @$slide = $('.slide', @model.getV())
    @total_slides = @$slide.length

    # Offset to account for first slide clone
    @active_index = 1

  ###
  *------------------------------------------*
  | onMouseDown:void (=)
  |
  | Mouse down.
  *----------------------------------------###
  onMouseDown: (e) =>

  ###
  *------------------------------------------*
  | onMouseMove:void (=)
  |
  | Mouse move.
  *----------------------------------------###
  onMouseMove: (e) =>

  ###
  *------------------------------------------*
  | onMouseUp:void (=)
  |
  | Mouse Up.
  *----------------------------------------###
  onMouseUp: =>

  ###
  *------------------------------------------*
  | onClickArrow:void (-)
  |
  | e:object - event object
  |
  | Click arrow.
  *----------------------------------------###
  onClickArrow: (e) =>
    @active_index = if $(e.currentTarget).hasClass('prev') then @active_index - 1 else @active_index + 1
    @updateSlider()

  ###
  *------------------------------------------*
  | updateShoe:void (=)
  |
  | Update shoe.
  *----------------------------------------###
  updateSlider: =>
    @trans_x = -(@active_index * 100)
    translate = LW.utils.translate("#{@trans_x + '%'}", 0)

    @$slider
      .css(LW.utils.transform, translate)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, @loopPosition)

  ###
  *------------------------------------------*
  | loopPosition:void (=)
  |
  | Loop for infinite gallery.
  *----------------------------------------###
  loopPosition: (e) =>
    oc = @active_index

    if @active_index is 0
      # Minus two to account for last slide clone
      @active_index = @total_slides - 2
    else if @active_index is @total_slides - 1
      @active_index = 1

    if oc isnt @active_index
      @$slider.addClass('no-trans')

      _.defer =>
        @updateSlider()

        @$slider[0].offsetHeight # clear CSS cache
        @$slider.removeClass('no-trans')

  ###
  *------------------------------------------*
  | reset:void (=)
  |
  | Reset.
  *----------------------------------------###
  reset: ->
    @$slider.removeClass('no-trans')
    @active_index = 1
    @trans_x = 0
    @updateSlider()

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @reset()

    @$slider
      .off("#{@mousedown} #{@mousemove}")
      .on(@mousedown, @onMouseDown)
      .on(@mousemove, @onMouseMove)
    
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
    @$slider.off("#{@mousedown} #{@mousemove}")
    @$arrow.off('click')

module.exports = SlideshowController