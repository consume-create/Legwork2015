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

# Error
ErrorModel = require './models/error-model'
ErrorController = require './controllers/error-controller'

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
    LW.$wrapper = $('#wrapper')
    LW.$app = $('#wrapper-inner')

    LW.data = require './data/index'
    # LW.error = require './data/error'
    LW.utils = require './utils'
    LW.url_regex = /[^a-z0-9*:_\-~]+/gi
    LW.router = new Routes({
      'regex': LW.url_regex,
      '$el': LW.$body
    })
    LW.virgin = true

    # Class vars
    @$pages_inner = $('#pages-inner')
    @$pages_trans = $('#pages-transition')
    @page_m = []
    @page_c = []

    # Global app size
    LW.size = {
      'window': [LW.$win.width(), LW.$win.height()],
      'app': [@$pages_inner.outerWidth(), @$pages_inner.outerHeight()]
    }

    @cling_to = -1
    @clinger_titles = ['Do you love me?', 'Could you learn to love me?', 'What about the boat times?', 'I got Bailey\'s.', 'Want to see my watercolors?', 'Don\'t lie to me, boy.', 'Love games?']
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
    # Add routes from structure defined in ./data/index
    for page_url, page of LW.data.pages
      for slide_url, slide of page.slides

        # Build the route
        if page_url is 'home' and slide_url is LW.LANDING_SLIDE
          r = '/'
        else if slide_url is LW.LANDING_SLIDE
          r = '/' + page_url
        else
          r = '/' + page_url + '/' + slide_url

        # Add it
        LW.router.add(r, 'Legwork Studio / ' + slide.browser_title)

        # Add details route if they exist
        if slide.details?
          LW.router.add('/' + page_url + '/' + slide_url + '/details', 'Legwork Studio / ' + slide.browser_title + ' Details')

        # Add watch route if it exists
        if slide.reel_video_id
          LW.router.add('/' + page_url + '/reel', 'Legwork Studio / Watch ' + slide.browser_title + ' Reel')
        else if slide.watch_video_id
          LW.router.add('/' + page_url + '/' + slide_url + '/watch', 'Legwork Studio / Watch ' + slide.browser_title)

  ###
  *------------------------------------------*
  | build:void (-)
  |
  | Build.
  *----------------------------------------###
  build: ->
    # Hey desktop, party on
    if LW.utils.is_mobile.any() is false
      LW.$body.addClass('party-on')

    # Header
    @header_m = new HeaderModel({'$el': $('header')})
    @header_c = new HeaderController({
      'model': @header_m
    })

    # Build page models / controllers
    for id, page of LW.data.pages
      $el = $('<div id="' + id + '" class="page" />').appendTo(@$pages_inner)
      @page_m[id] = new PageModel({
        'id': id,
        'slides': page.slides,
        '$el': $el,
        'color_index': page.color_index
      })
      @page_c[id] = new PageController({
        'model': @page_m[id]
      })

      # Build cool nav buttons
      if id isnt 'home'
        @header_c.buildACoolButton(id)

    # Transition
    @transition_m = new TransitionModel({'$el': @$pages_trans})
    @transition_c = new TransitionController({
      'model': @transition_m
    })

    # Error
    $error_e = $('<div id="error" class="page" />').appendTo(@$pages_inner)
    @error_m = new ErrorModel({
      '$el': $error_e,
      'messages': LW.data.error.messages
    })
    @error_c = new ErrorController({
      'model': @error_m
    })

    @observeSomeSweetEvents()

  ###
  *------------------------------------------*
  | observeSomeSweetEvents:void (-)
  |
  | Observe some sweet events.
  *----------------------------------------###
  observeSomeSweetEvents: ->
    # Add callbacks for routes
    LW.router.on('ERROR:404', @on404)
    LW.router.on('/', @goToPage)
    for page_url, page of LW.data.pages
      LW.router.on('/' + page_url + '/*', @goToPage)

    # Trigger the initial route
    LW.router.onAppStateChange()

    LW.$win
      .on('blur', (e) =>
        @unclung_title = document.title
        @stageFiveClingerMode()
      )
      .on('focus', @backToNormalMode)
      .on('resize', @onWindowResize)

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
    document.title = @unclung_title
    @cling_to = -1

  ###
  *------------------------------------------*
  | onWindowResize:void (=)
  |
  | e:object - event object
  |
  | Handle window resize.
  *----------------------------------------###
  onWindowResize: (e) =>
    LW.size = {
      'window': [LW.$win.width(), LW.$win.height()],
      'app': [@$pages_inner.outerWidth(), @$pages_inner.outerHeight()]
    }

    @active_c.resize()
    @transition_c.resize()

  ###
  *------------------------------------------*
  | goToPage:void (=)
  |
  | route:object - current route
  |
  | Go to page.
  *----------------------------------------###
  goToPage: (route) =>
    id = if route.url is '/' then 'home' else route.key.split(':')[0]
    @header_c.setState(id)

    if @page_c[id] is @active_c
      @active_c.goToSlide(route)
    else if @active_c is null
      @page_c[id].activate()
      @active_c = @page_c[id]
      @active_c.goToSlide(route)
    else
      direction = if @page_c[id].model.getE().index() < @active_c.model.getE().index() then 'right' else 'left'
      @active_c.turnHandlers('off') unless @active_c is @error_c

      if @transition_c.running_hot is true
        @transition_c.suspend()

      @transition_c.activate()
      @transition_c.go(
        direction,
        =>
          @suspend()
          @page_c[id].activate(route)
          @active_c = @page_c[id]
          @active_c.goToSlide(route)
        ,
        =>
          @transition_c.suspend()
      )

  ###
  *------------------------------------------*
  | on404:void (=)
  |
  | route:object - current route
  |
  | 404.
  *----------------------------------------###
  on404: (route) =>
    @suspend()
    @error_c.activate()
    @active_c = @error_c

  ###
  *------------------------------------------*
  | suspend:void (-)
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