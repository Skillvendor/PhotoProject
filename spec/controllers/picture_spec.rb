require "rails_helper"
require 'base64'
require 'open-uri'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Api::V1::PicturesController, type: :controller do
	let(:category) { FactoryGirl.create(:category) }
	let(:user) { }

	describe 'GET /pictures' do
		before(:each) do
			@picture = FactoryGirl.create(:picture, category_id: category.id)
      get :index, format: :json
    end
			
		it 'creates a resource' do
			expect(response.content_type).to be(Mime::JSON.to_s)
		end

		it 'responds with 200' do
			expect(response).to have_http_status(200)
		end

		it 'responds with resource' do
			body = JSON.parse(response.body)
			expect(body).to include('data')
			body = body['data'][0]
			expect(body).to include('id')
			expect(body).to include('relationships')
			expect(body).to include('attributes')
		end
	end 

	describe 'POST /pictures' do
		context 'when it is a valid request' do
			before(:each) do
				params = FactoryGirl.build(:picture, title: 'TestPic', category_id: category.id).attributes
				file_contents = "data:image/jpeg;base64," + Base64.encode64(open("#{Rails.root}/spec/support/index.jpeg") { |f| f.read })
				params['photo'] = file_contents
				post :create, picture: params , format: :json
			end

			it 'creates a resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				data = body['data']
				expect(data['attributes']['title']).to eq('TestPic')
			end

			it 'responds with 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when it is not a valid request' do
			before(:each) do
				params = FactoryGirl.build(:picture, :without_title, category_id: category.id).attributes
				post :create, picture: params , format: :json
			end

			it 'creates errors resource' do
				body = JSON.parse(response.body)
				expect(body).to include('errors')
			end

			it 'responds with 400' do
				expect(response).to have_http_status(400)
			end
		end
	end

	describe 'PATCH/PUT /pictures/:id' do
		context 'when it is a valid request' do
			let(:attr) do 
    		{ title: 'new title' }
  		end

  		before(:each) do
				@pic = FactoryGirl.create(:picture, :category_id: category.id)
				patch :update, id: @pic.id, picture: attr, format: :json
				@pic.reload
			end

			it 'changes the title of the picture' do
				expect(@pic.title).to eq('new title')
			end

			it 'responds with 202' do
				expect(response).to have_http_status(202)
			end

			it 'creates a resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				data = body['data']
				expect(data['attributes']['title']).to eq('new title')
			end
		end

		context 'when it is not a valid request' do
			let(:attr) do 
    		{ title: nil }
  		end

  		before(:each) do
				@pic = FactoryGirl.create(:picture, category_id: category.id)
				patch :update, id: @pic.id, picture: attr, format: :json
				@pic.reload
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

	describe 'DELETE /pictures/:id' do
		context 'when it is a valid request' do
			before(:each) do
				@pic = FactoryGirl.create(:picture, category_id: category.id)
				delete :destroy, id: @pic.id, format: :json
			end

			it 'responds with 204' do
				expect(response).to have_http_status(204)
			end
		end
	end

	describe 'GET /pictures/:id (SHOW)' do
		context 'when it is a valid request' do
			before(:each) do
				@pic = FactoryGirl.create(:picture, category_id: category.id)
				get :show, id: @pic.id, format: :json
			end

			it 'creates a resource' do
				expect(response.content_type).to be(Mime::JSON.to_s)
			end

			it 'responds with 200' do
				expect(response).to have_http_status(200)
			end

			it 'responds with resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				body = body['data']
				expect(body).to include('id')
				expect(body).to include('relationships')
				expect(body).to include('attributes')
			end
		end
	end

	describe 'POST /pictures/:id/like' do 
		context 'when it is a valid request' do
  		before(:each) do
  			@user = FactoryGirl.create(:user)
				sign_in(@user)
				@pic = FactoryGirl.create(:picture, category_id: category.id)
				@likes = @pic.reputation_for(:likes)
				post :like, id: @pic.id, format: :json
				@pic.reload
			end

			it 'increments likes on first call' do
				expect(@likes + 1).to eq(@pic.reputation_for(:likes))
			end

			it 'decrements likes on second call' do
				post :like, id: @pic.id, format: :json
				@pic.reload
				expect(@likes).to eq(@pic.reputation_for(:likes))
			end

			it 'creates a resource' do
				expect(response.content_type).to be(Mime::JSON.to_s)
			end

			it 'responds with 200' do
				expect(response).to have_http_status(200)
			end

			it 'responds with resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				body = body['data']
				expect(body).to include('id')
				expect(body).to include('relationships')
				expect(body).to include('attributes')
			end
		end
	end
end