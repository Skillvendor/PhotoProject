require 'jsonapi-serializers'

class PictureSerializer < ActiveModel::Serializer
	include JSONAPI::Serializer

	attribute :title
  attribute :description
  attribute :category_id
  attribute :photo
  attribute :created_at

  has_many :comments do
  	Comment.where(picture_id: object)
  end

  attribute :likes do
   object.reputation_for(:likes)
  end

  attribute :dislikes do
   object.reputation_for(:dislikes)
  end
end
