require "rails_helper"

RSpec.describe Api::V1::CommentsController, :type => :controller do
	include_context 'comments'

	describe 'POST /comments' do
		context 'when it is a valid request' do
			before(:each) do
				setup_requirements
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
				setup_requirements
				params = FactoryGirl.build(:comment, :without_text, :picture_id => @picture.id).attributes
				post :create, :comment => params , :format => :json
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

	describe 'PATCH /api/comments/:id' do
		context 'when it is a valid request' do
			let(:attr) do 
    		{ :text => 'update' }
  		end

			before(:each) do
				setup_requirements
				@comment = FactoryGirl.create(:comment, :picture_id => @picture.id, :user_id => @user.id)
				patch :update, :id => @comment.id, :comment => attr , :format => :json
			end

			it 'creates a resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				data = body['data']
				expect(data['attributes']['text']).to eq('update')
			end

			it 'responds with 202' do
				expect(response).to have_http_status(202)
			end
		end
	end

	describe 'DELETE /api/comments/:id' do
		context 'when it is a valid request' do
			before(:each) do
				setup_requirements
    		@comment = FactoryGirl.create(:comment, :picture_id => @picture.id, :user_id => @user.id)
				delete :destroy, :id => @comment.id, :format => :json
			end

			it 'responds with 204' do
				expect(response).to have_http_status(204)
			end
		end
	end
end