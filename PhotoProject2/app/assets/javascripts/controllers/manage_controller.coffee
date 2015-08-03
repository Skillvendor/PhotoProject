#= require routes

angular.module('App')
.controller 'ManageController', ['$scope', '$mdDialog', ($scope, $mdDialog) ->

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
                image: -> return $scope.imagePreview
		)

]

angular.module('App')
.controller 'AddPictureModalController', ['$scope', '$mdDialog', 'image', 'CategoryResource', ($scope, $mdDialog, image, CategoryResource) ->
	
	$scope.image = image
	CategoryResource.get (result) -> 
		$scope.categories = result.data

	$scope.hide = ->
		$mdDialog.hide()

	$scope.cancel = ->
		$mdDialog.cancel()

	$scope.uploadPhoto = ->
		$scope.photos.save

]