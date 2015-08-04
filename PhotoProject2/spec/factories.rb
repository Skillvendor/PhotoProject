FactoryGirl.define do
	factory :category do |f|
		f.sequence(:name) { |n| "foo#{n}" }
	end

	
end