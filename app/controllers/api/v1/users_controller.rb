module Api
  module V1
    class UsersController < Api::V1::BaseController
      include Devise::Controllers::Helpers

      before_filter :authenticate_user!, :except => [:create, :show]

      def show
        render json: serialize_model(current_user), :status => :ok
      end

      def create
        @user = User.create(user_params)
        if @user.valid?
          sign_in(@user)
          render json: serialize_model(@user), :status => :created
        else
          render json: { :errors => @user.errors }, :status => 400
        end
      end

      def update
        respond_with :api, User.update(current_user.id, user_params)
      end

      def destroy
        respond_with :api, User.find(current_user.id).destroy
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end