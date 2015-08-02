#= require routes

angular.module('App')
.controller 'MainController', ['$scope', 'CategoryResource', 'PhotoResource', ($scope, CategoryResource, PhotoResource) ->

	CategoryResource.get (result) -> 
		$scope.categories = result.data

	PhotoResource.get (result) -> 
		$scope.photos = result.data

]