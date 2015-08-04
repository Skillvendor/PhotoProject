#= require routes

angular.module('App')
.factory 'PhotoService', ['$http', ($http) -> 
 	all: -> 
 		$http.get('/api/pictures')
 	save: (picture) ->
 		$http.post('/api/pictures', picture)
]