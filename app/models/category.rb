class Category < ActiveRecord::Base
	has_many :pictures, dependent: :destroy
	validates :name, presence: true, uniqueness: { case_sensitive: false }
end