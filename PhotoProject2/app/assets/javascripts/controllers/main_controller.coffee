#= require routes

angular.module('App')
.controller("MainController", ['$scope', 'CategoryResource', ($scope, CategoryResource) ->

	CategoryResource.get (result) -> 
		$scope.categories = result.data

])