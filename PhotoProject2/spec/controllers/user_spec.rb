require "rails_helper"
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Api::V1::UsersController, :type => :controller do

	describe 'GET /api/users' do
		context 'when the user is logged in' do
			before(:each) do
				user = FactoryGirl.create(:user, :email => 'test_email@yahoo.com')
				login_as(user, scope: :user)
	      get :show, :format => :json
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
				expect(body).to include('attributes')
				body = body['attributes']
				expect(body).to include('email')
				expect(body['email']).to eq('test_email@yahoo.com')
			end
		end
	end 

	describe 'POST /api/users' do
		context 'when it creates an account' do
			before(:each) do
				params = {:email => 'test_email@yahoo.com', :password => 'password', :password_confirmation => 'password'}
	      post :create, :user => params, :format => :json
	    end
				
			it 'creates a resource' do
				expect(response.content_type).to be(Mime::JSON.to_s)
			end

			it 'responds with 201' do
				expect(response).to have_http_status(201)
			end

			it 'responds with resource' do
				body = JSON.parse(response.body)
				expect(body).to include('data')
				body = body['data']
				expect(body).to include('attributes')
				body = body['attributes']
				expect(body).to include('email')
				expect(body['email']).to eq('test_email@yahoo.com')
			end
		end

		context 'when a password problem occurs' do
			before(:each) do
				params = {:email => 'test_email@yahoo.com', :password => '321', :password_confirmation => 'password'}
	      post :create, :user => params, :format => :json
	    end
				
			it 'creates a resource' do
				expect(response.content_type).to be(Mime::JSON.to_s)
			end

			it 'responds with 400' do
				expect(response).to have_http_status(400)
			end

			it 'responds with resource' do
				body = JSON.parse(response.body)
				expect(body).to include('errors')
				body = body['errors']
				expect(body).to include('password')
			end
		end

		context 'when an email problem occurs' do
			before(:each) do
				params = {:email => 'test', :password => 'password', :password_confirmation => 'password'}
	      post :create, :user => params, :format => :json
	    end
				
			it 'creates a resource' do
				expect(response.content_type).to be(Mime::JSON.to_s)
			end

			it 'responds with 400' do
				expect(response).to have_http_status(400)
			end

			it 'responds with resource' do
				body = JSON.parse(response.body)
				expect(body).to include('errors')
				body = body['errors']
				expect(body).to include('email')
			end
		end

		context 'when a password_confirmation problem occurs' do
			before(:each) do
				params = {:email => 'test_email@yahoo.com', :password => 'password', :password_confirmation => 'password321'}
	      post :create, :user => params, :format => :json
	    end
				
			it 'creates a resource' do
				expect(response.content_type).to be(Mime::JSON.to_s)
			end

			it 'responds with 400' do
				expect(response).to have_http_status(400)
			end

			it 'responds with resource' do
				body = JSON.parse(response.body)
				expect(body).to include('errors')
				body = body['errors']
				expect(body).to include('password_confirmation')
			end
		end
	end

	describe 'PATCH/PUT /api/users' do
		context 'when it is a valid request' do
			let(:attr) do 
	    	{ :email => 'new_email@yahoo.com' }
	  	end

	  	before(:each) do
				@user = FactoryGirl.create(:user)
				sign_in(@user)
				patch :update, :user => attr, :format => :json
				@user.reload
			end

			it 'changes the email of the user' do
				expect(@user.email).to eq('new_email@yahoo.com')
			end

			it 'responds with 204' do
				expect(response).to have_http_status(204)
			end
		end
	end

	describe 'DELETE /api/users' do
		context 'when it is a valid request' do

	  	before(:each) do
				@user = FactoryGirl.create(:user)
				sign_in(@user)
				delete :destroy
			end

			it 'responds with 200' do
				expect(response).to have_http_status(200)
			end
		end
	end  
end