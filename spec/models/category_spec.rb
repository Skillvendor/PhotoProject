require "rails_helper"


describe Category do

	describe "#valid?" do
	
		context 'when category is valid' do
			let(:category) { FactoryGirl.create(:category) }

			it 'it is valid' do
				expect(category).to be_valid
			end
		end

		context 'when its name is null' do
			let(:category) { FactoryGirl.build(:category, :without_name) }
			
			it 'is not valid' do
				category.save
				expect(category.errors[:name].size).to eq(1)
			end
		end

		context 'when name is a duplicate' do
			let(:category1) { FactoryGirl.build(:category, name: 'Test') }
			let(:category2) { FactoryGirl.build(:category, name: 'test') } 

			it 'is not valid' do
				category1.save
				category2.save
				expect(category2.errors[:name].size).to eq(1)
			end
		end

	end
end