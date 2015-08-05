class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :picture

  validates :text, presence: true
  validates :user_id, presence: true
  validates :picture_id, presence: true
end
