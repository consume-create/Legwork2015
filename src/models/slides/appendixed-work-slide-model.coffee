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

    # Validate type and length
    if _.isArray(projects) is false or (projects.length < 1 or projects.length > 6)
      passed = false
      throw 'ERROR: projects must be an array of at least 1 object, but no more than 6'

    # Pare it down to what we need and validate individual stuff
    sanitized_projects = _.map(projects, (obj) ->
      if _.isArray(obj.title) is false or obj.title.length isnt 2
        passed = false
        throw 'ERROR: title must be an array of 2 strings'
      else if obj.title[0].length > LW.TITLE_MAX or obj.title[1].length > LW.TITLE_MAX
        passed = false
        throw 'ERROR: title parts must be ' + LW.TITLE_MAX + ' characters or less'

      if _.isString(obj.tagline) is false
        passed = false
        throw 'ERROR: tagline must be a string'

      if _.isString(obj.launch_url) is false
        throw 'ERROR: launch_url must be a string'

      return _.pick(obj, 'title', 'tagline', 'launch_url')
    )

    if passed is true
      @_projects = sanitized_projects

module.exports = AppendixedWorkSlideModel