class PicturesController < ApplicationController
	include SerializerModule

	before_action :set_category, only: [:create]
	before_action :set_pic, only: [:show, :destroy]
	before_action :get_comments, only: [:show]

	def index
		@pictures = Picture.all

		respond_to do |format|
      format.html { }
      format.json { render json: serialize_models(@pictures)}
    end
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
        format.json { render json: serialize_model(@pic) }
      else
        format.html { render :new }
        format.json { render json: @pic.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  	respond_to do |format|
      format.html { }
      format.json { render json: serialize_model(@pic, include: ['comments'])}
    end
  end

  def destroy
  	respond_to do |format|
  		if @pic.destroy
        format.html { redirect_to pictures_path, notice: 'Poza a fost stearsa' }
        format.json { head :no_content}
      else
        format.html { render :index }
        format.json { render json: serialize_model(@pic.errors) }
      end
    end
  end

private

	def set_category
		@category = Category.find(params[:category_id])
	end

	def set_pic
		@pic = Picture.find(params[:id])
	end

	def picture_params
		params.require(:picture).permit(:photo, :description, :category_id)
	end

	def get_comments
		@comments = @pic.comments
	end

end
