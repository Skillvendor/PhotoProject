shared_context 'comments' do
	def setup_requirements
	  @category = FactoryGirl.create(:category)
	  @picture = FactoryGirl.create(:picture, :category_id => @category.id)
	  @user = FactoryGirl.create(:user)
	  sign_in(@user)
	end
end