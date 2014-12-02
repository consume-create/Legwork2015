###

Copyright (c) 2014 Legwork Studio. All Rights Reserved. Your wife is still hot.

###

# Dependencies
BaseSlideModel = require './base-slide-model'

class AppendixedWorkSlideModel extends BaseSlideModel

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

    @_projects = null
    @setProjects(data.projects)

  ###
  *------------------------------------------*
  | getProjects:object (-)
  |
  | Get projects.
  *----------------------------------------###
  getProjects: ->
    return @_projects

  ###
  *------------------------------------------*
  | setProjects:void (-)
  |
  | projects:object - projects object
  |
  | Set projects.
  *----------------------------------------###
  setProjects: (projects) ->
    total = projects.length

    if _.isArray(projects) is false or (total < 1 or total > 6)
      throw 'ERROR: projects must be an array of at least 1 object, but no more than 6.'
    else
      @_projects = projects

module.exports = AppendixedWorkSlideModel