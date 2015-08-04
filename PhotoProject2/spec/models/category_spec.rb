require 'spec_helper'
require "rails_helper"


describe Category do
	
	context 'validates category model' do

		it 'should validate a valid category' do
			category = FactoryGirl.build(:category)
			expect(category).to be_valid
		end

		it 'fails validation if no name is present' do
			category = Category.create(name: nil)
			expect(category.errors[:name].size).to eq(1)
		end

		it 'fails validation if the name is not unique' do
			category1 = Category.create(name: 'Test')
			category2 = Category.create(name: 'Test')
			expect(category2.errors[:name].size).to eq(1)
		end

		it 'fails validation if the name is not unique, responding to case sensitivity' do
			category1 = Category.create(name: 'Test')
			category2 = Category.create(name: 'test')
			expect(category2.errors[:name].size).to eq(1)
		end

	end
end