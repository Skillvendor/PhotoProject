require 'jsonapi-serializers'

class ErrorSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attribute :content do
    object.body
  end
end
