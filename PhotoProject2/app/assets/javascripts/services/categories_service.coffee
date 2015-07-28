#= require routes

angular.module('App')
.factory 'CategoryResource', ['$resource', ($resource) -> 
	 $resource '/categories/:id.json', {id: '@id'}
]
