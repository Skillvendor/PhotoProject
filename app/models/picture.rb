class Picture < ActiveRecord::Base
	belongs_to :category, counter_cache: true
	has_many :comments, dependent: :destroy
	mount_base64_uploader :photo, PhotoUploader
	validates :photo, presence: true
	validates :title, presence: true
	validates :category_id, presence: true
end