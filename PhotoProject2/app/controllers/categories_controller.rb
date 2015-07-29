class CategoriesController < ApplicationController
	include SerializerModule

	before_action :set_category, only: [:destroy, :update]

  respond_to :json

	def index
		@categories = Category.all
    render json: serialize_models(@categories)
	end

  def new
  end

	def create 
		@category = Category.new(category_params)
    if @category.save
      render json: serialize_model(@category, is_collection: false)
    else
      render json: @category.errors
    end
  end

  def destroy
    if @category.destroy
      head :no_content 
    else
      render json: serialize_model(@category.errors)
    end
  end

  def update
    if @category.update_attributes(category_params)
      render json: serialize_model(@category)
    else
      render json: @category.errors
    end
  end

private

	def category_params
		params.require(:category).permit(:name)
	end

	def set_category
		@category = Category.where(params[:id]).first
	end
end
