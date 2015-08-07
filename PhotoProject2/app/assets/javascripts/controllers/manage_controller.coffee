#= require routes

angular.module('App')
.controller 'ManageController', ['$scope', '$mdDialog', 'PhotoService', 'FileUploader', '$base64', ($scope, $mdDialog, PhotoService, FileUploader) ->

	$scope.uploader = new FileUploader({url: '/api/pictures'})

	$scope.getPictures = ->
		PhotoService.all()
			.success (result) ->
				$scope.pictures = result.data
			.error ->
				alert('There has been an error. Please try again later')
	
	$scope.getPictures()

	$scope.uploadPhoto = (element) ->
        photofile = element.files[0]
        $scope.uploader.clearQueue()
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
			else
				alert('There has been an error. Please try again later')
		
]

angular.module('App')
.controller 'AddPictureModalController', ['$scope', '$mdDialog', 'photoPreview', 'CategoryService', 'PhotoService', ($scope, $mdDialog, photoPreview, CategoryService, PhotoService) ->
	
	$scope.picture = {photo: photoPreview}

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
				$mdDialog.hide('success')
			.error ->
				$mdDialog.hide('error')
]