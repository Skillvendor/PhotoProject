require "rails_helper"


RSpec.describe Api::V1::CommentsController, :type => :controller do

	describe 'POST /comments' do
		context 'when it is a valid request' do
			before(:each) do
				@category = FactoryGirl.create(:category)
				@picture = FactoryGirl.create(:picture, :category_id => @category.id)
				@user = FactoryGirl.create(:user)
				params = FactoryGirl.build(:comment, :text => 'TestCom', :picture_id => @picture.id).attributes 
				post :create, :comment => params , :format => :json
			end

			it 'creates a resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				data = body['data']
				expect(data['attributes']['text']).to eq('TestCom')
			end

			it 'responds with 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when it is not a valid request' do
			before(:each) do
				params = FactoryGirl.build(:comment, :without_text).attributes 
				post :create, :comments => params , :format => :json
			end

			it 'responds with 400' do
				expect(response).to have_http_status(400)
			end

			it 'creates errors resource' do
				body = JSON.parse(response.body)
				expect(body).to include('errors')
			end
		end
	end

end