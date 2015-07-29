class Picture < ActiveRecord::Base
	belongs_to :category
	has_many :comments, dependent: :destroy
	mount_uploader :photo, PhotoUploader
	validates_presence_of :photo
end