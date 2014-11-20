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

    # Cache selectors
    @$primary_nav = $('#primary-nav')

    # Observe
    @observeSomeSweetEvents()

  ###
  *------------------------------------------*
  | observeSomeSweetEvents:void (-)
  |
  | Observe some sweet events.
  *----------------------------------------###
  observeSomeSweetEvents: ->
    @$primary_nav.on('click', '.nav-item', @onClickNavItem)

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
  | buildACoolButton:String (-)
  |
  | id:object - id
  |
  | Build and append primary nav links.
  *----------------------------------------###
  buildACoolButton: (id) ->
    @$primary_nav.append('<a class="nav-item ajaxy" data-id="' + id + '" href="/' + id + '">' + id + '<span></span></a>')
    @$nav_items = $('.nav-item', @model.getV())

  ###
  *------------------------------------------*
  | setState:void (-)
  |
  | state:string
  |
  | Set nav state.
  *----------------------------------------###
  setState: (state) ->
    @$nav_items.removeClass('active')
    @$nav_items.filter('[data-id="' + state + '"]').addClass('active')

module.exports = HeaderController