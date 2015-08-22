shared_context 'pictures' do
	def log_in_admin(user)
		user.admin = true
		user.save
		sign_in(user)
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

	shared_examples 'not an admin' do
		it 'creates a resource' do
			body = JSON.parse(response.body)
			expect(body).to include('errors')
			data = body['errors']
			expect(data).to include('admin')
		end

		it 'responds with 401' do
			expect(response).to have_http_status(401)
		end
	end
end