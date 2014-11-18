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
  | buildACoolButton:String (-)
  |
  | id:object - id
  |
  | Build and append primary nav links.
  *----------------------------------------###
  buildACoolButton: (id) ->
    $nav_item = '<a class="nav-item ajaxy" data-id="' + id + '" href="/' + id + '">' + id + '<span></span></a>'
    $('#primary-nav').append($nav_item)

  ###
  *------------------------------------------*
  | setState:void (-)
  |
  | Set nav state.
  *----------------------------------------###
  setState: ->
    k = LW.router.getState().key.split(':')[0]

    $('.nav-item', @model.getV()).removeClass('active')
    $('.nav-item[data-id="' + k + '"]', @model.getV()).addClass('active')

module.exports = HeaderController