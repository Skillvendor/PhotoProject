#= require routes

angular.module('App')
.controller 'ManageController', ['$scope', '$mdDialog', 'PhotoService', ($scope, $mdDialog, PhotoService) ->

	PhotoService.all()
		.success (result) ->
			$scope.pictures = result.data
		.error ->
			alert('There has been an error. Please try again later')

	$scope.uploadPhoto = (element) ->
        photofile = element.files[0]
        reader = new FileReader()
        reader.onload = (e) ->
            $scope.$apply ->
                $scope.imagePreview = e.target.result
                $scope.showAddPictureModal(this)
        reader.readAsDataURL(photofile)

	$scope.showAddPictureModal = (event) ->
		$mdDialog.show(
			controller: 'AddPictureModalController',
			templateUrl: 'add_picture_modal.html',
			targetEvent: event,
			resolve:
                photo: -> return $scope.imagePreview
		)

]

angular.module('App')
.controller 'AddPictureModalController', ['$scope', '$mdDialog', 'photo', 'CategoryService', 'PhotoService', ($scope, $mdDialog, photo, CategoryService, PhotoService) ->
	
	$scope.picture = {photo: photo}

	CategoryService.all()
		.success (result) -> 
			$scope.categories = result.data
		.error ->
			alert('There has been an error. Please try again later')
			$mdDialog.cancel()

	$scope.cancel = ->
		$mdDialog.cancel()

	$scope.uploadPhoto = ->
		PhotoService.save($scope.picture)
			.success (result) ->
				$mdDialog.hide()
			.error ->
				alert('There has been an error. Please try again later')
				$mdDialog.hide()
]