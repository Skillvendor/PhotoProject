require 'jsonapi-serializers'

class CategorySerializer < ActiveModel::Serializer
	include JSONAPI::Serializer

  attribute :name

  has_many :pictures do
  	Picture.where(category_id: object)
  end
end
