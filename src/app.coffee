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
    LW.router.add('/', 'Legwork Studio / Creativity. Innovation. DIY Ethic.')
    LW.router.add('/about/~', 'Legwork Studio / About Us.')
    LW.router.add('/work/~', 'Legwork Studio / Our Work.')

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

    # Home
    # TODO: write nav buttons here?
    for id, page of LW.data.pages
      $el = $('<div id="' + id + '" class="page" />').appendTo(@$pages_inner)
      @page_m[id] = new PageModel({'id': id, '$el': $el})
      @page_c[id] = new PageController({
        'model': @page_m[id]
      })

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
    LW.router.on('/', @goToPage)
    LW.router.on('/about/*', @goToPage)
    LW.router.on('/work/*', @goToPage)
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
    console.log(route)
    @header_c.setState()

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