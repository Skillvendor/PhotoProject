module Api
  module V1
    class CategoriesController < ApplicationController
    	include SerializerModule

    	before_action :set_category, only: [:destroy, :update, :show]

      before_filter only: [:create, :update] do
        unless params.has_key?('category')
          render nothing: true, status: :bad_request
        end
      end

      respond_to :json

    	def index
    		@categories = Category.all
        render json: serialize_models(@categories)
    	end

      def new
      end

      def show
        render json: serialize_model(@category, include: ['pictures'])
      end

    	def create 
    		@category = Category.new(category_params)
        if @category.save
          render json: serialize_model(@category)
        else
          render json: @category.errors, :status => :bad_request
        end
      end

      def destroy
        if @category.destroy
          head :no_content 
        else
          render json: serialize_model(@category.errors), :status => :bad_request
        end
      end

      def update
        if @category.update_attributes(category_params)
          render json: serialize_model(@category)
        else
          render json: @category.errors, :status => :bad_request
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
    		@category = Category.where(id: params[:id]).first
    	end
    end
  end
end
