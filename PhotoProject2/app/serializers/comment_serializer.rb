require 'jsonapi-serializers'

class CommentSerializer < ActiveModel::Serializer
	include JSONAPI::Serializer

  attribute :text
  attribute :user_id
  attribute :picture_id
end
