angular.module('Courses.services')
.factory 'elasticSearch', (
  $q,
  ejsResource,
) ->
  ES_URL = 'http://db.data.adicu.com:9200'
  ejs = ejsResource(ES_URL)
  request = ejs.Request().indices('jdbc')

  executeCourseQuery: (query, term) ->
    d = $q.defer()
    request
      .query(
          ejs.BoolQuery()
          .must(ejs.WildcardQuery('term', '*' + term  + '*'))
          .should(ejs.QueryStringQuery(query + '*')
            .fields(['coursetitle^3', 'course^4', 'description',
              'coursesubtitle', 'instructor^2']))
          .should(ejs.QueryStringQuery('*' + query + '*')
            .fields(['course', 'coursefull']))
          .minimumNumberShouldMatch(1)
      )
      .doSearch()
      .then (data) ->
        d.resolve data
    d.promise
