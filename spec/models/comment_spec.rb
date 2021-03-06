require "rails_helper"


describe Comment do
	
	describe '#valid?' do
		let(:user) { FactoryGirl.create(:user) }
    let(:category) { FactoryGirl.create(:category) }
    let(:pic) { FactoryGirl.create(:picture, category_id: category.id) }

		context 'when comment is valid' do
			let(:comment) { comment = FactoryGirl.create(:comment, user_id: user.id, picture_id: pic.id) }
			
			it 'is valid' do
				expect(comment).to be_valid
			end
		end

		context 'when its text is nil' do
			let(:comment) { FactoryGirl.build(:comment, :without_text, user_id: user.id, picture_id: pic.id) }

			it 'is not valid' do
				comment.save
				expect(comment.errors[:text].size).to eq(1)
			end
		end

		context 'when its user_id is nil' do
			let(:comment) { FactoryGirl.build(:comment, :without_user_id, picture_id: pic.id) }

			it 'is not valid' do
				comment.save
				expect(comment.errors[:user_id].size).to eq(1)
			end
		end

		context 'when its picture_id is nil' do
			let(:comment) { FactoryGirl.build(:comment, :without_picture_id, user_id: user.id) }

			it 'is not valid' do
				comment.save
				expect(comment.errors[:picture_id].size).to eq(1)
			end
		end

	end
end