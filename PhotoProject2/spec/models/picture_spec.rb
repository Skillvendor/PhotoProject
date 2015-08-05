require "rails_helper"


describe Picture do
	
	describe "#valid?" do

		context	'when picture is valid' do
			let(:pic) { FactoryGirl.create(:picture) }

			it 'is a valid picture' do
				expect(pic).to be_valid
			end
		end

		context 'when its title is nil' do
			let(:pic) { FactoryGirl.build(:picture, :without_title)}

			it 'is not valid' do
				pic.save
				expect(pic.errors[:title].size).to eq(1)
			end
		end

		context 'when its description is nil' do
			let(:pic) { FactoryGirl.build(:picture, :description => nil)}

			it 'is valid' do
				pic.save
				expect(pic).to be_valid
			end
		end

		context 'when no picture is present' do
			let(:pic) { FactoryGirl.build(:picture, :without_photo)}

			it 'is not valid' do
				pic.save
				expect(pic.errors[:photo].size).to eq(1)
			end
		end

	end
end