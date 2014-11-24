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
    passed = true
    max = 6
    total = projects.length
    diff = max - total

    if _.isArray(projects) is false or (total < 1 or total > max)
      passed = false
      throw 'ERROR: projects must be an array of at least 1 object, but no more than ' + max + ''

    # To ensure our appendix grid has 6 cells,
    # add the difference of empty objects to the array of projects
    if total < max
      for i in [0...diff]
        projects.push({})

    if passed is true
      @_projects = projects

module.exports = AppendixedWorkSlideModel