require "rails_helper"


describe Picture do
	
	describe "#valid?" do
		let(:category) { FactoryGirl.create(:category) }
		
		context	'when picture is valid' do
			let(:pic) { FactoryGirl.create(:picture, :category_id => category.id) }

			it 'is a valid picture' do
				expect(pic).to be_valid
			end
		end

		context 'when its title is nil' do
			let(:pic) { FactoryGirl.build(:picture, :without_title, :category_id => category.id)}

			it 'is not valid' do
				pic.save
				expect(pic.errors[:title].size).to eq(1)
			end
		end

		context 'when its description is nil' do
			let(:pic) { FactoryGirl.build(:picture, :without_description, :category_id => category.id)}

			it 'is valid' do
				pic.save
				expect(pic).to be_valid
			end
		end

		context 'when no picture is present' do
			let(:pic) { FactoryGirl.build(:picture, :without_photo, :category_id => category.id)}

			it 'is not valid' do
				pic.save
				expect(pic.errors[:photo].size).to eq(1)
			end
		end

		context 'when no category_id is present' do
			let(:pic) { FactoryGirl.build(:picture, :without_category)}

			it 'is not valid' do
				pic.save
				expect(pic.errors[:category_id].size).to eq(1)
			end
		end

	end
end