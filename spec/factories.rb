FactoryGirl.define do
	factory :category do |f|
		f.sequence(:name) { |n| "foo#{n}" }

		trait :without_name do
			name nil
		end
	end

	factory :picture do |f|
		f.title "PozaDinFactory"
		f.description "DescriereDinFactory"
		f.association :category_id, factory: :category
		f.photo { File.new("#{Rails.root}/spec/support/index.jpeg") }

		trait :without_photo do
    	photo nil
  	end

  	trait :without_title do
  		title nil
  	end

  	trait :without_description do
  		description nil
  	end 

  	trait :without_category do
  		category_id nil
  	end
	end

	factory :comment do |f|
		f.text "Un comentariu din factory Girl"
		f.association :picture_id, factory: :picture
		f.association :user_id, factory: :user

		trait :without_text do
			text nil
		end

		trait :without_user_id do
			user_id nil
		end

		trait :without_picture_id do
			picture_id nil
		end
	end

	factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"

    trait :without_email do
    	email nil
    end
  end
end