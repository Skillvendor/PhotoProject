class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :recoverable, :rememberable, :trackable, :validatable
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :evaluations, class_name: "RSEvaluation", as: :source

  def voted?(name, pic)
    pic.evaluators_for(name).include?(self)
  end
end
