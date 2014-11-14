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

    if k is 'about'
      @$nav_item.eq(0).addClass('active')
    if k is 'work'
      @$nav_item.eq(1).addClass('active')

module.exports = HeaderController