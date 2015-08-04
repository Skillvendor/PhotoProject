require 'spec_helper'
require "rails_helper"


describe Picture do
	
	context 'validates picture model' do

		it 'should validate a valid picture' do
			pic = FactoryGirl.create(:picture)
			expect(pic).to be_valid
		end

		it 'fails validation if no title is present' do
			pic = Picture.create(title: nil, description: "DescriereDinFactory", category_id: 1,
			                      photo: File.new("#{Rails.root}/spec/support/index.jpeg"))
			expect(pic.errors[:title].size).to eq(1)
		end

		it 'validates if no description is present' do
			pic = Picture.create(title: "titlu", description: nil, category_id: 1,
			                      photo: File.new("#{Rails.root}/spec/support/index.jpeg"))
			expect(pic).to be_valid
		end

		it 'fails validation if no picture is present' do
			pic = Picture.create(title: "titlu", description: "Descriere", category_id: 1,
			                      photo: nil)
			expect(pic.errors[:photo].size).to eq(1)
		end

	end
end