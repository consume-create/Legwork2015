###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

class HeaderController

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
    @model.setV($(JST['header-view'](LW.data)))
    @model.getE().append(@model.getV())

    # Build nav elements based on pages
    $html = ''
    for id, page of LW.data.pages
      if id isnt 'home'
        $html += '<a class="nav-item ajaxy" data-id="' + id + '" href="/' + id + '">' + id + '<span></span></a>'

    # Append primary nav elements
    $('#primary-nav').append($html)

    # Class vars
    @$nav_item = $('.nav-item', @model.getV())

    # Observe
    @observeSomeSweetEvents()

  ###
  *------------------------------------------*
  | observeSomeSweetEvents:void (-)
  |
  | Observe some sweet events.
  *----------------------------------------###
  observeSomeSweetEvents: ->
    @$nav_item.on('click', @onClickNavItem)

  ###
  *------------------------------------------*
  | onClickNavItem:void (-)
  |
  | Click nav item.
  | If it is already active, do nothing.
  *----------------------------------------###
  onClickNavItem: (e) ->
    if $(e.currentTarget).hasClass('active')
      return false

  ###
  *------------------------------------------*
  | setState:void (-)
  |
  | Set nav state.
  | Lazy version, set only active on
  | About or Work, do nothing for landing.
  *----------------------------------------###
  setState: ->
    k = LW.router.getState().key.split(':')[0]
    @$nav_item.removeClass('active')
    $('.nav-item[data-id="' + k + '"]', @model.getV()).addClass('active')

module.exports = HeaderController