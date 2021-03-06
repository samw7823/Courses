courseHelper = require '../helpers/courseHelper'
mongoose = require 'mongoose'
Q = require 'q'

CourseData = mongoose.model 'CourseData'
SectionData = mongoose.model 'SectionData'

cFindOne = Q.nbind CourseData.findOne, CourseData
sFindOne = Q.nbind SectionData.findOne, SectionData

exports.query = (req, res) ->
  console.log req.params

  req.assert('courseID').isAlphanumeric()
  req.assert('term').isInt().len(5)

  courseID = req.params.courseID
  term = req.params.term
  courseHelper.findCourseAndGetSections(courseID)
  .done (data) ->
    res.jsonp data
  , (err) ->
    # Todo: err handling
    res.jsonp err
