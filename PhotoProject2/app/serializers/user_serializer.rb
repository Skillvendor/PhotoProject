require 'jsonapi-serializers'

class UserSerializer < ActiveModel::Serializer
	include JSONAPI::Serializer

  attribute :email
end
