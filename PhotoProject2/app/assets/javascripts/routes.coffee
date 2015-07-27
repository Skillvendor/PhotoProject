app = angular.module('App', ['ngRoute', 'templates'])

app.config(['$routeProvider', ($routeProvider)->

    $routeProvider
      .when('/',
        templateUrl: "photoTemplate.html"
        controller: 'PhotoController'
      )

])
