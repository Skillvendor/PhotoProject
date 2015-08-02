#= require routes

angular.module('App')
.factory 'CategoryResource', ['$resource', ($resource) -> 
	 $resource 'api/categories/:id.json', {id: '@id'}
]
