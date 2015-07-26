require 'jsonapi-serializers'

class CategorySerializer < ActiveModel::Serializer
	include JSONAPI::Serializer

  attribute :name
end
