module Api
  module V1
    class PicturesController < ApplicationController
    	include SerializerModule

    	before_action :set_pic, only: [:show, :destroy, :update]
    	before_action :get_comments, only: [:show]

      before_filter only: [:create] do
        unless params.has_key?('picture')
          render nothing: true, status: :bad_request
        end
      end

      respond_to :json

    	def index
    		@pictures = Picture.all
        render json: serialize_models(@pictures)
    	end

    	def new
    	end

    	def create
    		@pic = Picture.new(picture_params)
        if @pic.save
          render json: serialize_model(@pic)
        else
          render json: @pic.errors
        end
      end

      def show
        render json: serialize_model(@pic, include: ['comments'])
      end

      def update
        if @pic.update_attributes(picture_params)
          render json: serialize_model(@pic)
        else
          render json: @pic.errors
        end
      end

      def destroy
      	if @pic.destroy
          head :no_content
        else
          render json: @pic.errors
        end
      end

    private

    	def set_pic
    		@pic = Picture.where(id: params[:id]).first
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