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
      'launch_url': @model.getLaunchUrl(),
      'media': @model.getMedia()
    })))
    @model.getE().append(@model.getV())

    # Cache selectors
    @$content = $('.content', @model.getV())
    @$black_box = $('.black-box', @model.getV())
    @$bg = $('.bg', @model.getV())
    @src = @$bg.attr('data-src')

  ###
  *------------------------------------------*
  | loadDetailTransition:void (=)
  |
  | Load detail and transition black box.
  *----------------------------------------###
  loadDetailTransition: =>
    $loader = $('.detail-loader', @model.getV())
    @$black_box.removeClass('slide-up')
    @$content.scrollTop(0)
    @model.getE()[0].offsetHeight # Reflow like a a defer

    if $loader.length > 0
      $loader.addClass('loading')
      $current = $('<img />').attr
        'src': @src
      .one 'load', (e) =>
        @$bg.attr('style': "background-image: url(#{@src})")
        $loader
          .addClass('loaded')
          .off()
          .one(LW.utils.transition_end, =>
            @$black_box.addClass('slide-up')
            $loader.removeClass('loading').remove()
          )

      if $current[0].complete is true
        $current.trigger('load')

      return $current[0]
    else
      @$black_box.addClass('slide-up')

  ###
  *------------------------------------------*
  | activate:void (-)
  |
  | Activate.
  *----------------------------------------###
  activate: ->
    @model.getE().addClass('active')
    @loadDetailTransition()

  ###
  *------------------------------------------*
  | suspend:void (-)
  |
  | Activate.
  *----------------------------------------###
  suspend: ->
    @model.getE().removeClass('active')

module.exports = WorkDetailController