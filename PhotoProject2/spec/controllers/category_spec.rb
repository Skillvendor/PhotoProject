require "rails_helper"


RSpec.describe Api::V1::CategoriesController, :type => :controller do

	describe "GET /categories" do
		before(:each) do
      get :index, :format => :json
    end
			
		it 'creates a resource' do
			expect(response.content_type).to be(Mime::JSON::Type)
		end

		it 'responds with 200' do
			expect(response).to have_http_status(200)
		end

	end
end