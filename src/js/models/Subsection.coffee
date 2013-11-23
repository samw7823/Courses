angular.module('Courses.models')
.factory 'Subsection', (
  CourseHelper,
) ->
  class Subsection
    constructor: (@data) ->
      # Set all of the properties on data to the new object
      _.extend @, @data
      @computeCSS()

    computeCSS: () ->
      @css = CourseHelper.computeCSS @startTime, @endTime

    isOnDay: (day) ->
      _.indexOf(@meetsOn, day) isnt -1

    isOverlapping: (other) ->
      if not (@endTime < other.startTime or other.endTime < @startTime)
        for thisDay in @meetsOn
          if other.isOnDay thisDay
            return true
      return false

    # Recalc the CSS for multiple overlapping sections
    @recalcCSS: (overlappingSubsections) ->
      overlappingSubsections = _.sortBy overlappingSubsections,
        (section) ->
          section.id
      currentLeft = 0
      width = 100 / overlappingSubsections.length
      for subsection in overlappingSubsections
        subsection.css.width = "#{width}%"
        subsection.css.left = "#{currentLeft}%"
        currentLeft += width
