#= require routes

angular.module('App')
.controller 'ManageController', ['$scope', '$mdDialog', 'PhotoService', ($scope, $mdDialog, PhotoService) ->

	$scope.getPictures = ->
		PhotoService.all()
			.success (result) ->
				$scope.pictures = result.data
			.error ->
				alert('There has been an error. Please try again later')
	
	$scope.getPictures()

	$scope.uploadPhoto = (element) ->
        photofile = element.files[0]
        reader = new FileReader()
        reader.onload = (e) ->
            $scope.$apply ->
                $scope.photoPreview = e.target.result
                $scope.showAddPictureModal(this)
        reader.readAsDataURL(photofile)

	$scope.showAddPictureModal = (event) ->
		$mdDialog.show(
			controller: 'AddPictureModalController',
			templateUrl: 'add_picture_modal.html',
			targetEvent: event,
			resolve:
                photoPreview: -> return $scope.photoPreview
		)
		.then (answer) ->
			if answer == 'success'
				$scope.getPictures()
			else if answer == 'error'
				alert('There has been an error. Please try again later')

			# clear all files from controller
			angular.forEach(
			    angular.element("input[type='file']"),
			    (inputElem) -> 
			    	angular.element(inputElem).val(null)
			)
		
]

angular.module('App')
.controller 'AddPictureModalController', ['$scope', '$mdDialog', 'photoPreview', 'CategoryService', 'PhotoService', ($scope, $mdDialog, photoPreview, CategoryService, PhotoService) ->
	
	$scope.picture = {photo: photoPreview}

	CategoryService.all()
		.success (result) -> 
			$scope.categories = result.data
		.error ->
			$mdDialog.hide('error')

	$scope.cancel = ->
		$mdDialog.hide('cancel')

	$scope.uploadPhoto = ->
		PhotoService.save($scope.picture)
	    	.success (result) ->
				$mdDialog.hide('success')
			.error ->
				$mdDialog.hide('error')
]