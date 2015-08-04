FactoryGirl.define do
	factory :category do |f|
		f.sequence(:name) { |n| "foo#{n}" }
	end

	factory :picture do |f|
		f.title "PozaDinFactory"
		f.description "DescriereDinFactory"
		f.association :category_id, factory: :category
		f.photo { File.new("#{Rails.root}/spec/support/index.jpeg") } 
	end

	factory :comment do |f|
		f.text "Un comentariu din factory Girl"
		f.association :picture_id, factory: :picture
		f.user_id 1
	end
end