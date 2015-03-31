###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseModel = require './base-model'

class PageNavModel extends BaseModel

  ###
  *------------------------------------------*
  | constructor:void (-)
  |
  | data:object - data
  |
  | Construct.
  *----------------------------------------###
  constructor: (data) ->
    super(data)

    @_links = null
    @setLinks(data.links)

  ###
  *------------------------------------------*
  | getLinks:String (-)
  |
  | Get links.
  *----------------------------------------###
  getLinks: ->
    return @_links

  ###
  *------------------------------------------*
  | setLinks:void (-)
  |
  | links:array - links
  |
  | Set links.
  *----------------------------------------###
  setLinks: (links) ->
    if _.isArray(links) is false
      throw 'ERROR: links must be an array of objects with properties id, url and title'
    else
      @_links = links

module.exports = PageNavModel