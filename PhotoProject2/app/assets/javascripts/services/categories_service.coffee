#= require routes

angular.module('App')
.factory 'CategoryService', ['$http', ($http) -> 
	all: -> 
 		$http.get('/api/categories')
]
