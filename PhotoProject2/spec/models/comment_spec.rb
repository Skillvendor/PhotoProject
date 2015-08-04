require 'spec_helper'
require "rails_helper"


describe Comment do
	
	context 'validates comment model' do

		it 'should validate a valid comment' do
			comment = FactoryGirl.create(:comment)
			expect(comment).to be_valid
		end

		it 'fails validation if no text is present' do
			comment = Comment.create(text: nil, user_id: 1, picture_id: 1)
			expect(comment.errors[:text].size).to eq(1)
		end

		it 'fails validation if no user is provided' do
			comment = Comment.create(text: 'Test', user_id: nil, picture_id: 1)
			expect(comment.errors[:user_id].size).to eq(1)
		end

		it 'fails validation if no picture is provided' do
			comment = Comment.create(text: 'Test', user_id: 1, picture_id: nil)
			expect(comment.errors[:picture_id].size).to eq(1)
		end
	end
end