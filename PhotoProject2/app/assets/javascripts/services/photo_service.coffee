#= require routes

angular.module('App')
.factory 'PhotoResource', ['$resource', ($resource) -> 
	 $resource 'api/pictures/:id.json', {id: '@id'}
]