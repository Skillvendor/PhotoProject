require 'rails_helper'


describe User do

	describe '#valid?' do
	
		context 'when it is a valid user' do
			let(:user) { FactoryGirl.create(:user) }

			it 'is valid' do
				expect(user).to be_valid
			end
		end

		context 'when its email is nil' do
			let(:user) { FactoryGirl.build(:user, :without_email) }

			it 'is not valid' do
				user.save
				expect(user.errors[:email].size).to eq(1)
			end
		end

		context 'when its email does not have a valid form' do
			let(:user) { FactoryGirl.build(:user, email: 'test') }

			it 'is not valid' do
				user.save
				expect(user.errors[:email].size).to eq(1)
			end
		end

		context 'when email is duplicate' do
			let(:user1) { FactoryGirl.build(:user, email: 'test@yahoo.com') }
			let(:user2) { FactoryGirl.build(:user, email: 'Test@yahoo.com') }

			it 'is not valid' do
				user1.save
				user2.save
				expect(user2.errors[:email].size).to eq(1)
			end
		end

		context 'when passwords do not match' do
			let(:user) { FactoryGirl.build(:user, password: 'pass1', password_confirmation: 'pass2') }

			it 'it is not valid' do
				user.save
				expect(user).to be_invalid
			end
		end

	end
end