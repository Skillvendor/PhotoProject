require "rails_helper"
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Api::V1::CommentsController, type: :controller do
	include_context 'comments'

	describe 'POST /comments' do
		context 'when it is a valid request' do
			before(:each) do
				setup_requirements_with_login
				params = FactoryGirl.build(:comment, text: 'TestCom', picture_id: @picture.id).attributes 
				post :create, comment: params, format: :json
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
				setup_requirements_with_login
				params = FactoryGirl.build(:comment, :without_text, picture_id: @picture.id).attributes
				post :create, comment: params, format: :json
			end

			it 'responds with 400' do
				expect(response).to have_http_status(400)
			end

			it 'creates errors resource' do
				body = JSON.parse(response.body)
				expect(body).to include('errors')
			end
		end

		context 'when the user is not logged in' do
			before(:each) do
				setup_requirements_without_login
				params = FactoryGirl.build(:comment, picture_id: @picture.id).attributes
				post :create, comment: params, format: :json
			end

			it_behaves_like "not logged in"
		end
	end

	describe 'PATCH /api/comments/:id' do
		context 'when it is a valid request' do
			let(:attr) do 
    		{ text: 'update' }
  		end

			before(:each) do
				setup_requirements_with_login
				@comment = FactoryGirl.create(:comment, picture_id: @picture.id, user_id: @user.id)
				patch :update, id: @comment.id, comment: attr , format: :json
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

		context 'when the user is not logged in' do
			let(:attr) do 
    		{ text: 'update' }
  		end

			before(:each) do
				setup_requirements_without_login
				@comment = FactoryGirl.create(:comment, picture_id: @picture.id, user_id: @user.id)
				patch :update, id: @comment.id, comment: attr , format: :json
			end

			it_behaves_like "not logged in"
		end

		context 'when the user is not the owner' do
			let(:attr) do 
    		{ text: 'update' }
  		end

			before(:each) do
				setup_requirements_with_login
				@comment = FactoryGirl.create(:comment, picture_id: @picture.id, user_id: @user.id)
				sign_out(@user)
				@user2 = FactoryGirl.create(:user)
				sign_in(@user2)
				patch :update, id: @comment.id, comment: attr , format: :json
			end

			it_behaves_like "not the owner"
		end
	end

	describe 'DELETE /api/comments/:id' do
		context 'when it is a valid request' do
			before(:each) do
				setup_requirements_with_login
    		@comment = FactoryGirl.create(:comment, picture_id: @picture.id, user_id: @user.id)
				delete :destroy, id: @comment.id, format: :json
			end

			it 'responds with 204' do
				expect(response).to have_http_status(204)
			end
		end

		context 'when the user is not logged in' do
			before(:each) do
				setup_requirements_without_login
				@comment = FactoryGirl.create(:comment, picture_id: @picture.id, user_id: @user.id)
				delete :destroy, id: @comment.id, format: :json
			end

			it_behaves_like "not logged in"
		end

		context 'when the user is not the owner' do
			before(:each) do
				setup_requirements_with_login
				@comment = FactoryGirl.create(:comment, picture_id: @picture.id, user_id: @user.id)
				sign_out(@user)
				@user2 = FactoryGirl.create(:user)
				sign_in(@user2)
				delete :destroy, id: @comment.id, format: :json
			end

			it_behaves_like "not the owner"
		end
	end
end