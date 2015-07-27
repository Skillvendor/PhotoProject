app = angular.module('App', ['ngRoute', 'ngResource', 'templates'])

app.config(['$routeProvider', ($routeProvider)->

    $routeProvider
      .when('/',
        templateUrl: "main.html"
        controller: 'MainController'
      )

])
