class Picture < ActiveRecord::Base
	belongs_to :category, counter_cache: true
	has_many :comments, dependent: :destroy
	mount_base64_uploader :photo, PhotoUploader

	has_reputation :likes, source: :user, aggregated_by: :sum
	has_reputation :dislikes, source: :user, aggregated_by: :sum

	validates :photo, presence: true
	validates :title, presence: true
	validates :category_id, presence: true

	scope :order_desc, -> { order(id: :desc)}

  def evaluate_reputation(name, user)
		if user.voted?(name, self)
      self.delete_evaluation(name, user)
    else
      self.add_evaluation(name, 1, user)
    end
  end  
end