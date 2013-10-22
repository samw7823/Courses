angular.module('Courses.controllers')
.controller 'navCtrl', (
  $scope,
  $rootScope,
  $location,
) ->
  styles = []

  $scope.$on '$routeChangeSuccess', ->
    clearStyles()
    location = $location.path()
    if location?
      shortLoc = location.slice(1)
      $scope[shortLoc] = 'active'
      styles.push shortLoc

  clearStyles = ->
    for style in styles
      $scope[style] = null

  $scope.fbUser = () ->
    $rootScope.fbUser
