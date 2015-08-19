class Picture < ActiveRecord::Base
	belongs_to :category, counter_cache: true
	has_many :comments, dependent: :destroy
	mount_base64_uploader :photo, PhotoUploader

	has_reputation :likes, source: :user, aggregated_by: :sum
	has_reputation :dislikes, source: :user, aggregated_by: :sum

	validates :photo, presence: true
	validates :title, presence: true
	validates :category_id, presence: true

	scope :order_desc, -> { order(created_at: :desc)}
end