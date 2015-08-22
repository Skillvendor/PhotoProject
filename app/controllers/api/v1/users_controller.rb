module Api
  module V1
    class UsersController < Api::V1::BaseController
      include Devise::Controllers::Helpers

      before_action :authenticate_user!, except: [:create, :show]
      before_action :signed_in_and_admin?, only: [:make_admin]

      def show
        render json: serialize_model(current_user), status: :ok
      end

      def create
        @user = User.create(user_params)
        if @user.valid?
          sign_in(@user)
          render json: serialize_model(@user), status: :created
        else
          render json: { errors: @user.errors }, status: :bad_request
        end
      end

      def update
        respond_with :api, User.update(current_user.id, user_params)
      end

      def destroy
        respond_with :api, User.find(current_user.id).destroy
      end

      def make_admin
        @user = User.find_by_email!(params[:email])
        @user.admin = true
        @user.save
        render json: serialize_model(@user), status: :accepted
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end