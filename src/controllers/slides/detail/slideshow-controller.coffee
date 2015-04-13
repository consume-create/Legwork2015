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
    @$initial_slide = $('.slide-img', @model.getV())
    @$arrow = $('.arrow', @model.getV())
    @$counter = $('.slideshow-counter', @model.getV())

    # Draggable vars
    @dragging = false
    @y_axis = false
    @drag_time = 666
    @trans_x = 0
    @start_time = 0
    @start_x = 0
    @current_x = 0
    @start_y = 0
    @current_y = 0
    @range = 30
    @current_range = 0
    @now = 0
    @inmotion = false
    @swiped = false

    @mousedown = if Modernizr.touch then "touchstart" else "mousedown"
    @mousemove = if Modernizr.touch then "touchmove" else "mousemove"
    @mouseup = if Modernizr.touch then "touchend" else "mouseup"

    # Clone to initial slides and store these selecotrs/vars
    @$initial_slide.eq(-1).clone().prependTo(@$slider)
    @$initial_slide.eq(0).clone().appendTo(@$slider)
    @$slide_img = $('.slide-img', @model.getV())
    @total_slides = @$slide_img.length

    # Offset to account for first slide clone
    @active_index = 1

  ###
  *------------------------------------------*
  | onMouseDown:void (=)
  |
  | Mouse down.
  *----------------------------------------###
  onMouseDown: (e) =>
    if @inmotion is false
      @dragging = true
      @slider_width = @$slider.width()
      @trans_x = -(@active_index * 100)

      @start_time = (new Date()).getTime()
      @start_x = if Modernizr.touch then e.originalEvent.pageX else e.pageX
      @start_y = if Modernizr.touch then e.originalEvent.pageY else e.pageY

      LW.$doc.off(@mouseup)
        .one(@mouseup, @onMouseUp)

  ###
  *------------------------------------------*
  | onMouseMove:void (=)
  |
  | Mouse move.
  *----------------------------------------###
  onMouseMove: (e) =>
    if @dragging is true and @y_axis is false
      @current_x = if Modernizr.touch then e.originalEvent.pageX else e.pageX
      @current_y = if Modernizr.touch then e.originalEvent.pageY else e.pageY
      @direction_x = @current_x - @start_x
      @current_range = if @start_x is 0 then 0 else Math.abs(@direction_x)
      current_range_y = if @start_y is 0 then 0 else Math.abs(@current_y - @start_y)

      if @current_range < current_range_y
        @y_axis = true
      else
        @now = (new Date()).getTime()
        drag_x = -(@active_index * @slider_width) + @direction_x

        @$slider
          .addClass('no-trans')
          .css(LW.utils.transform, LW.utils.translate(drag_x + 'px', 0))

        return false

  ###
  *------------------------------------------*
  | onMouseUp:void (=)
  |
  | Mouse Up.
  *----------------------------------------###
  onMouseUp: =>
    if @$slider.hasClass('no-trans')
      @$slider.removeClass('no-trans')

      if @now - @start_time < @drag_time and @current_range > @range or @current_range > (@slider_width / 2)
        @swiped = true
        if @current_x > @start_x
          @previous()
        else
          @next()
      else
        @inmotion = true
        @$slider
          .css(LW.utils.transform, LW.utils.translate(-(@active_index * @slider_width) + 'px', 0))
          .off(LW.utils.transition_end)
          .one(LW.utils.transition_end, =>
            @inmotion = false
          )

    @dragging = false
    @swiped = false
    @y_axis = false
    return false

  ###
  *------------------------------------------*
  | onClickArrow:void (-)
  |
  | e:object - event object
  |
  | Click arrow.
  *----------------------------------------###
  onClickArrow: (e) =>
    if @inmotion is true
      return false

    if $(e.currentTarget).hasClass('prev') then @previous() else @next()

  ###
  *------------------------------------------*
  | previous:void (=)
  |
  | Previous slide.
  *----------------------------------------###
  previous: =>
    @active_index = @active_index - 1
    @updateSlider()

  ###
  *------------------------------------------*
  | next:void (=)
  |
  | Next slide.
  *----------------------------------------###
  next: =>
    @active_index = @active_index + 1
    @updateSlider()

  ###
  *------------------------------------------*
  | updateShoe:void (=)
  |
  | Update shoe.
  *----------------------------------------###
  updateSlider: =>
    @inmotion = true
    @trans_x = -(@active_index * 100)
    translate = LW.utils.translate("#{@trans_x + '%'}", 0)

    if @swiped is true
      @$slider.addClass('swiped')

    @$slider
      .css(LW.utils.transform, translate)
      .off(LW.utils.transition_end)
      .one(LW.utils.transition_end, @loopPosition)

    # @updateCounter()

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
        @$slider.removeClass('no-trans swiped')
        @inmotion = false
    else
      @inmotion = false

    # update counter
    @updateCounter()

  ###
  *------------------------------------------*
  | updateCounter:void (-)
  |
  | Update counter.
  *----------------------------------------###
  updateCounter: ->
    @$counter.text(('0' + (@active_index)).slice(-2) + ' / ' + ('0' + (@total_slides - 2)).slice(-2))

  ###
  *------------------------------------------*
  | reset:void (=)
  |
  | Reset.
  *----------------------------------------###
  reset: =>
    @$slider.removeClass('no-trans')
    @trans_x = 0
    @active_index = 1
    @updateSlider()

    # reset these after update slider to ensure these have reset
    @y_axis = false
    @swiped = false
    @inmotion = false

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