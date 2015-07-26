class CategoriesController < ApplicationController

	def index
		@categories = Category.all
	end

  def new
  	@category = Category.new
  end

	def create 
		@category = Category.new(category_params)

		respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Categoria a fost creata' }
        format.json { render json: @category, status: :created}
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@category = Category.find(params[:id])
  	
  	if @category.destroy
  		flash[:succes] = "Categoria a fost stearsa"
  		redirect_to categories_path
  	else
  		flash[:danger] = "Categoria nu a putut sa fie stearsa"
  		redirect_to categories_path
  	end
  end

private

	def category_params
		params.require(:category).permit(:name)
	end
end
