module Api
  module V1
    class PicturesController < Api::V1::BaseController
    	before_action :set_pic, only: [:show, :destroy, :update]
    	before_action :get_comments, only: [:show]
      
      respond_to :json

    	def index
    		@pictures = Picture.all
        render json: serialize_models(@pictures), :status => :ok
    	end

    	def new
    	end

    	def create
    		@pic = Picture.new(picture_params)
        if @pic.save
          render json: serialize_model(@pic), :status => :created
        else
          render json: { :errors => @pic.errors }, :status => :bad_request
        end
      end

      def show
        render json: serialize_model(@pic, include: ['comments'])
      end

      def update
        if @pic.update_attributes(picture_params)
          render json: serialize_model(@pic), :status => :accepted
        else
          render json: { :errors => @pic.errors }, :status => :bad_request
        end
      end

      def destroy
      	if @pic.destroy
          head :no_content, :status => :no_content
        else
          render json: { :errors => @pic.errors }, :status => :bad_request
        end
      end

    private

    	def set_pic
    		@pic = Picture.find_by_id(params[:id])
    	end

    	def picture_params
    		params.require(:picture).permit(:title, :photo, :description, :category_id)
    	end

    	def get_comments
    		@comments = @pic.comments
    	end
    end
  end
end