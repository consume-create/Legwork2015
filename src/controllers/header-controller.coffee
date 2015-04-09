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

    # details mode
    LW.$body
      .on('gear_up_and_get_after_it', (e) => @turnDetailsClose('on'))
      .on('back_out_and_gear_down', (e) => @turnDetailsClose('off'))

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
    @$primary_nav_items.append('<li><a class="nav-item ajaxy" data-id="' + id + '" href="/' + id + '">' + id + '<span></span></a></li>')
    @$nav_items = $('.nav-item', @model.getV())

  ###
  *------------------------------------------*
  | turnDetailsClose:String (-)
  |
  | s:string - on / off
  |
  | Details close on / off.
  *----------------------------------------###
  turnDetailsClose: (s) ->
    if s is 'on'
      y = -40
      href = LW.router.getState().url.replace(/\/reel|\/details|\/watch/i, '')
      LW.$wrapper.addClass('inverse')
    else
      y = 0
      href = 'javascript:void(0);'
      LW.$wrapper.removeClass('inverse')

    @$primary_nav_inner.css(LW.utils.transform, LW.utils.translate('0px', y + 'px'))
    @$close_btn.attr('href', href)

  ###
  *------------------------------------------*
  | setState:void (-)
  |
  | state:string
  |
  | Set nav state.
  *----------------------------------------###
  setState: (state) ->
    @$nav_items.removeClass('active').filter('[data-id="' + state + '"]').addClass('active')

module.exports = HeaderController