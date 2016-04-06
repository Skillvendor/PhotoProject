module Api
  module V1
    class CategoriesController < Api::V1::BaseController
      before_action :set_category, only: [:destroy, :update, :show]
      before_action :signed_in_and_admin?, only: [:create, :destroy, :update]

      respond_to :json

      def index
        @categories = Category.all
        render json: serialize_models(@categories), status: :ok
      end

      def new
      end

      def show
        render json: serialize_model(@category, include: ['pictures'])
      end

      def create 
        @category = Category.new(category_params)
        if @category.save
          render json: serialize_model(@category), status: :created
        else
          render json: { errors: @category.errors }, status: :bad_request
        end
      end

      def destroy
        if @category.destroy
          head :no_content, status: :no_content
        else
          render json: { errors: @category.errors }, status: :bad_request
        end
      end

      def update
        if @category.update_attributes(category_params)
          render json: serialize_model(@category), status: :accepted
        else
          render json: { errors: @category.errors }, status: :bad_request
        end
      end

      def categories_with_pics
        @categories = Category.all
        render json: serialize_models(@categories, include: ['pictures'])
      end

    private

      def category_params
        params.require(:category).permit(:name)
      end

      def set_category
        @category = Category.find_by_id(params[:id])
      end
    end
  end
end
