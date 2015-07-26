class PicturesController < ApplicationController

	before_action :set_category, only: [:create]

	def index
		@pictures = Picture.all
	end

	def new
		@pic = Picture.new
		@categories = Category.all
	end

	def create
		@pic = @category.pictures.create(picture_params)

		respond_to do |format|
      if @category.save
        format.html { redirect_to pictures_path, notice: 'Poza a fost adaugata' }
        format.json { render json: @pic, status: :created}
      else
        format.html { render :new }
        format.json { render json: @pic.errors, status: :unprocessable_entity }
      end
    end
  end

private

	def set_category
		@category = Category.find(params[:category_id])
	end

	def picture_params
		params.require(:picture).permit(:photo, :description, :category_id)
	end

end
