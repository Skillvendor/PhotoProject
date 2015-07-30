require 'jsonapi-serializers'

class PictureSerializer < ActiveModel::Serializer
	include JSONAPI::Serializer

  attribute :description
  attribute :category_id
  attribute :photo
  attribute :created_at


  has_many :comments do
  	Comment.where(picture_id: object)
  end
end
