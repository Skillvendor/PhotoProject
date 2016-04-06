require 'jsonapi-serializers'

class CategorySerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attribute :name
  attribute :pictures_count

  has_many :pictures do
    Picture.where(category_id: object).order_desc
  end
end
