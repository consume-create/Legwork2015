###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
Env = require './env'
Routes = require './routes'

# Header
HeaderModel = require './models/header-model'
HeaderController = require './controllers/header-controller'

# Page
PageModel = require './models/page-model'
PageController = require './controllers/page-controller'

# Transition
TransitionModel = require './models/transition-model'
TransitionController = require './controllers/transition-controller'

class Application

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | Construct.
  *----------------------------------------###
  constructor: ->
    # Globals
    LW.$doc = $(document)
    LW.$win = $(window)
    LW.$html = $('html')
    LW.$body = $('body')
    LW.$app = $('#wrapper-inner')

    LW.data = require './data/index'
    LW.utils = require './utils'
    LW.url_regex = /[^a-z0-9*:_\-~]+/gi
    LW.router = new Routes({
      'regex': LW.url_regex,
      '$el': LW.$body
    })

    # Class vars
    @$pages_inner = $('#pages-inner')
    @$pages_trans = $('#pages-transition')
    @page_m = []
    @page_c = []

    @cling_to = -1
    @clinger_titles = ['Do you love me?', 'Could you learn to love me?', 'What about the boat times?', 'I got Bailey\'s', 'Want to see my watercolors?', 'Don\'t lie to me, boy.']
    @$fallback = $('#fallback')
    @active_c = null

    # Supported?
    if @$fallback.is(':hidden')
      @$fallback.remove()
      @routes()
      @build()

  ###
  *------------------------------------------*
  | routes:void (-)
  |
  | Set up the routes.
  *----------------------------------------###
  routes: ->
    # Add flexible routes based on pages
    for id, page of LW.data.pages
      if id is 'home'
        LW.router.add('/' + id + '/', 'Legwork Studio / ' + page.title + '')
      else
        LW.router.add('/' + id + '/~', 'Legwork Studio / ' + page.title + '')

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    # Header
    @header_m = new HeaderModel({'$el': $('header')})
    @header_c = new HeaderController({
      'model': @header_m
    })

    # Build flexible MC's and primary nav based on pages
    $nav_html = ''
    for id, page of LW.data.pages
      $el = $('<div id="' + id + '" class="page" />').appendTo(@$pages_inner)
      @page_m[id] = new PageModel({'id': id, '$el': $el})
      @page_c[id] = new PageController({
        'model': @page_m[id]
      })

      if id isnt 'home'
        $nav_html += '<a class="nav-item ajaxy" data-id="' + id + '" href="/' + id + '">' + id + '<span></span></a>'

    # Append $nav elements
    $('#primary-nav').append($nav_html)

    # Transition
    @transition_m = new TransitionModel({'$el': @$pages_trans})
    @transition_c = new TransitionController({
      'model': @transition_m
    })

    @observeSomeSweetEvents()

  ###
  *------------------------------------------*
  | observeSomeSweetEvents:void (-)
  |
  | Observe some sweet events.
  *----------------------------------------###
  observeSomeSweetEvents: ->
    # Add flexible router event listeners based on pages
    for id, page of LW.data.pages
      if id is 'home'
        LW.router.on('/', @goToPage)
      else
        LW.router.on('/' + id + '/*', @goToPage)

    # Observe the initial route
    LW.router.onAppStateChange()

    LW.$win
      .on('blur', @stageFiveClingerMode)
      .on('focus', @backToNormalMode)

  ###
  *------------------------------------------*
  | stageFiveClingerMode:void (=)
  |
  | Don't leave us!
  *----------------------------------------###
  stageFiveClingerMode: =>
    document.title = if @cling_to is -1 then @clinger_titles[0] else _.sample(@clinger_titles)
    clearTimeout(@cling_to)
    @cling_to = setTimeout(@stageFiveClingerMode, 3000)

  ###
  *------------------------------------------*
  | backToNormalMode:void (=)
  |
  | Oh, thank the good lord.
  *----------------------------------------###
  backToNormalMode: =>
    clearTimeout(@cling_to)
    document.title = LW.router.routes[LW.router.getState().key].title
    @cling_to = -1

  ###
  *------------------------------------------*
  | goToPage:void (=)
  |
  | route:object - current route
  |
  | Go to page.
  *----------------------------------------###
  goToPage: (route) =>
    for id, page of LW.data.pages
      if id is route.key
        page = @page_c[id]
        break

    @header_c.setState()
    
    if @active_c isnt null
      @suspend()
      page.activate()
      @active_c = page
    else
      page.activate()
      @active_c = page

  ###
  *------------------------------------------*
  | suspend:void (=)
  |
  | Suspend all.
  *----------------------------------------###
  suspend: ->
    if @active_c isnt null
      @active_c.suspend()

module.exports = Application

$ ->
  # instance
  LW.instance = new Application()