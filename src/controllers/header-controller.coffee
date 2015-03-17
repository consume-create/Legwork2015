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
    @$primary_nav_inner = $('#primary-nav-inner', @model.getV())
    @$primary_nav_items = $('#primary-nav-inner ul:first', @model.getV())
    @$close_btn = $('#close-project-btn', @model.getV())

    # Observe
    @observeSomeSweetEvents()

  ###
  *------------------------------------------*
  | observeSomeSweetEvents:void (-)
  |
  | Observe some sweet events.
  *----------------------------------------###
  observeSomeSweetEvents: ->
    @$primary_nav_items.on('click', '.nav-item', @onClickNavItem)
    @$close_btn.on('click', @onClickCloseBtn)

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
  | onClickCloseBtn:void (=)
  |
  | Click close btn.
  *----------------------------------------###
  onClickCloseBtn: (e) =>
    LW.close_project = false
    LW.$body.trigger('rip_hide_details')
    @navTransition()

  ###
  *------------------------------------------*
  | buildACoolButton:String (-)
  |
  | id:object - id
  |
  | Build and append primary nav links.
  *----------------------------------------###
  buildACoolButton: (id) ->
    @$primary_nav_items.append('<li><a class="nav-item ajaxy" data-id="' + id + '" href="/' + id + '">' + id + '<span></span></a></li>')
    @$nav_items = $('.nav-item', @model.getV())

  ###
  *------------------------------------------*
  | navTransition:String (-)
  |
  | Nav transition.
  *----------------------------------------###
  navTransition: ->
    y = if LW.close_project is false then 0 else 40
    obj = {}
    obj[LW.utils.transform] = LW.utils.translate(0,-y + 'px')
    @$primary_nav_inner.css(obj)

  ###
  *------------------------------------------*
  | setState:void (-)
  |
  | state:string
  |
  | Set nav state.
  *----------------------------------------###
  setState: (state) ->
    LW.close_project = false
    
    @navTransition()
    @$nav_items.removeClass('active').filter('[data-id="' + state + '"]').addClass('active')
    

module.exports = HeaderController