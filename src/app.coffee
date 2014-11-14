###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
Env = require './env'
Routes = require './routes'

# Header
HeaderModel = require './models/header-model'
HeaderController = require './controllers/header-controller'

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
    LW.$sections = $('#sections')

    LW.data = require './data'
    LW.utils = require './utils'
    LW.url_regex = /[^a-z0-9*:_\-~]+/gi
    LW.router = new Routes({
      'regex': LW.url_regex,
      '$el': LW.$body
    })

    # Class vars
    @clinger_titles = ['Do you love me?', 'Could you learn to love me?', 'What about the boat times?', 'I got Bailey\'s', 'Want to see my watercolors?']
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
  | first:boolean - first?
  |
  | Don't leave us!
  *----------------------------------------###
  stageFiveClingerMode: (first = false) =>
    document.title = if first is true then @clinger_titles[0] else _.sample(@clinger_titles)
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