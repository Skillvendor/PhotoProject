require "rails_helper"


RSpec.describe Api::V1::CategoriesController, type: :controller do

	describe 'GET /categories' do
		before(:each) do
      get :index, format: :json
    end
			
		it 'creates a resource' do
			expect(response.content_type).to be(Mime::JSON.to_s)
		end

		it 'responds with 200' do
			expect(response).to have_http_status(200)
		end
	end

	describe 'POST /categories' do
		context 'when it is a valid request' do
			before(:each) do
				params = FactoryGirl.build(:category, name: 'TestCat').attributes 
				post :create, category: params, format: :json
			end

			it 'creates a resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				data = body['data']
				expect(data['attributes']['name']).to eq('TestCat')
			end

			it 'responds with 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when it is not a valid request' do
			before(:each) do
				params = FactoryGirl.build(:category, :without_name).attributes 
				post :create, category: params , format: :json
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

	describe 'PATCH/PUT /categories/:id' do
		context 'when it is a valid request' do
			let(:attr) do 
    		{ name: 'new name' }
  		end

			before(:each) do
				@category = FactoryGirl.create(:category)
				patch :update, id: @category.id, category: attr, format: :json
				@category.reload
			end

			it 'changes the name of the category' do
				expect(@category.name).to eq('new name')
			end

			it 'responds with 202' do
				expect(response).to have_http_status(202)
			end

			it 'creates a resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				data = body['data']
				expect(data['attributes']['name']).to eq('new name')
			end
		end

		context 'when it is not a valid request' do
			let(:attr) do 
    		{ name: nil }
  		end

			before(:each) do
				@category = FactoryGirl.create(:category)
				patch :update, id: @category.id, category: attr, format: :json
				@category.reload
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

	describe 'DESTROY /categories/:id' do
		context 'when it is a valid request' do
			before(:each) do
				@category = FactoryGirl.create(:category)
				delete :destroy, id: @category.id, format: :json
			end

			it 'responds with 204' do
				expect(response).to have_http_status(204)
			end
		end
	end

	describe 'GET /categories/categories_with_pics' do
		before(:each) do
			@category = FactoryGirl.create(:category)
			@picture = FactoryGirl.create(:picture, category_id: @category.id)
			get :categories_with_pics, format: :json
		end

		it 'creates a resource' do
			expect(response.content_type).to be(Mime::JSON.to_s)
		end

		it 'responds with resource' do
			body = JSON.parse(response.body)
			expect(body).to include('data')
			body = body['data'][0]
			expect(body).to include('id')
			expect(body).to include('relationships')
			expect(body).to include('attributes')
		end

		it 'responds with 200' do
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET /categories/:id (SHOW)' do
		context 'when it is a valid request' do
			before(:each) do
				@category = FactoryGirl.create(:category)
				get :show, id: @category.id , format: :json
			end

			it 'responds with resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				body = body['data']
				expect(body).to include('id')
				expect(body).to include('relationships')
				expect(body).to include('attributes')
			end

			it 'responds with 200' do
				expect(response).to have_http_status(200)
			end
		end
	end
end