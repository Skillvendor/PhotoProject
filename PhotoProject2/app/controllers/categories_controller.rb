class CategoriesController < ApplicationController

	include SerializerModule

	before_action :set_category, only: [:destroy]

	def index
		@categories = Category.all

		respond_to do |format|
      format.html { }
      format.json { render json: serialize_models(@categories)}
    end
	end

  def new
  	@category = Category.new
  end

	def create 
		@category = Category.new(category_params)

		respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Categoria a fost creata' }
        format.json { render json: serialize_model(@category, is_collection: false)}
      else
        format.html { render :new, notice: 'Categoria nu a putut sa fie salvata' }
        format.json { render json: serialize_model(@category.errors) }
      end
    end
  end

  def destroy
    @product.destroy
    
    respond_to do |format|
      format.html { redirect_to categories_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

	def category_params
		params.require(:category).permit(:name)
	end

	def set_category
		@category = Category.find(params[:id])
	end
end
