#= require routes

angular.module('App')
.controller 'ManageController', ['$scope', '$mdDialog', 'PhotoService', 'FileUploader', ($scope, $mdDialog, PhotoService, FileUploader) ->

	$scope.uploader = new FileUploader({url: '/api/pictures'})

	PhotoService.all()
		.success (result) ->
			$scope.pictures = result.data
		.error ->
			alert('There has been an error. Please try again later')

	$scope.uploadPhoto = (element) ->
        photofile = element.files[0]
        $scope.uploader.clearQueue()
        reader = new FileReader()
        reader.onload = (e) ->
            $scope.$apply ->
                $scope.uploader.addToQueue(photofile)
                $scope.photoPreview = e.target.result
                $scope.showAddPictureModal(this)
        reader.readAsDataURL(photofile)

	$scope.showAddPictureModal = (event) ->
		$mdDialog.show(
			controller: 'AddPictureModalController',
			templateUrl: 'add_picture_modal.html',
			targetEvent: event,
			resolve:
                uploader: -> return $scope.uploader
                photoPreview: -> return $scope.photoPreview
		)

]

angular.module('App')
.controller 'AddPictureModalController', ['$scope', '$mdDialog', 'uploader', 'photoPreview', 'CategoryService', 'PhotoService', ($scope, $mdDialog, uploader, photoPreview, CategoryService, PhotoService) ->
	
	$scope.photoPreview = photoPreview
	$scope.picture = uploader.queue[0]

	CategoryService.all()
		.success (result) -> 
			$scope.categories = result.data
		.error ->
			alert('There has been an error. Please try again later')
			$mdDialog.cancel()

	$scope.cancel = ->
		$mdDialog.cancel()

	$scope.uploadPhoto = ->
		uploader.uploadItem($scope.picture)
		#PhotoService.save($scope.picture)
	    #	.success (result) ->
		#		$mdDialog.hide()
		#	.error ->
		#		alert('There has been an error. Please try again later')
		#		$mdDialog.hide()
]