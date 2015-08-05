class Picture < ActiveRecord::Base
	belongs_to :category, counter_cache: true
	has_many :comments, dependent: :destroy
	mount_uploader :photo, PhotoUploader
	validates :photo, presence: true
	validates :title, presence: true
end