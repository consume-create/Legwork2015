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

    @_id = ''
    @setId(data.id)

    @_ids = null
    @setIds(data.ids)

    @_titles = null
    @setTitles(data.titles)

  ###
  *------------------------------------------*
  | getId:String (-)
  |
  | Get ID.
  *----------------------------------------###
  getId: ->
    return @_id

  ###
  *------------------------------------------*
  | setId:void (-)
  |
  | id:string - id
  |
  | Set ID.
  *----------------------------------------###
  setId: (id) ->
    @_id = id

  ###
  *------------------------------------------*
  | getIds:array (-)
  |
  | Get ids.
  *----------------------------------------###
  getIds: ->
    return @_ids

  ###
  *------------------------------------------*
  | setIds:void (-)
  |
  | ids:array - ids array
  |
  | Set ids.
  *----------------------------------------###
  setIds: (ids) ->
    if _.isArray(ids) is false
      throw 'ERROR: ids must be an array of ids'
    else
      @_ids = ids

  ###
  *------------------------------------------*
  | getTitles:array (-)
  |
  | Get titles.
  *----------------------------------------###
  getTitles: ->
    return @_titles

  ###
  *------------------------------------------*
  | setTitles:void (-)
  |
  | titles:array - titles array
  |
  | Set titles.
  *----------------------------------------###
  setTitles: (titles) ->
    if _.isArray(titles) is false
      throw 'ERROR: titles must be an array of titles'
    else
      @_titles = titles

module.exports = PageNavModel