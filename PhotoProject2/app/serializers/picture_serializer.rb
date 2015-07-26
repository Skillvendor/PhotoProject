require 'jsonapi-serializers'

class PictureSerializer < ActiveModel::Serializer
	include JSONAPI::Serializer

  attribute :description
  attribute :category_id
  attribute :photo
end
