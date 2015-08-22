shared_context 'comments' do
	def setup_requirements_without_login
		@user = FactoryGirl.create(:user)
	  @category = FactoryGirl.create(:category)
	  @picture = FactoryGirl.create(:picture, category_id: @category.id, user_id: @user.id)
	end

	def setup_requirements_with_login
		setup_requirements_without_login
	  sign_in(@user)
	end

	shared_examples 'not logged in' do
		it 'creates a resource' do
			body = JSON.parse(response.body)
			expect(body).to include('errors')
			data = body['errors']
			expect(data).to include('user')
		end

		it 'responds with 401' do
			expect(response).to have_http_status(401)
		end
	end

	shared_examples 'not the owner' do
		it 'creates a resource' do
			body = JSON.parse(response.body)
			expect(body).to include('errors')
			data = body['errors']
			expect(data).to include('user')
		end

		it 'responds with 401' do
			expect(response).to have_http_status(401)
		end
	end
end