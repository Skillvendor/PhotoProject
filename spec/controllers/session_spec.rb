require "rails_helper"
require 'base64'
require 'open-uri'

RSpec.describe Api::V1::SessionsControllerController, :type => :controller do

	describe 'GET /pictures' do
		before(:each) do
			@category = FactoryGirl.create(:category)
			@picture = FactoryGirl.create(:picture, :category_id => @category.id)
      get :index, :format => :json
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
end