module Api
  module V1
    class CommentsController < Api::V1::BaseController
      before_action :check_login
      before_action :get_comment, only: [:destroy, :update] 

      before_filter only: [:create] do
        unless params.has_key?('comment') 
          render nothing: true, status: :bad_request
        end
      end

      respond_to :json

    	def create
    		@comment = Comment.new(comment_params.merge(:user_id => current_user.id))
        if @comment.save
          render json: serialize_model(@comment), :status => :created
        else
          render json: { :errors => @comment.errors }, :status => :bad_request
        end
    	end

    	def destroy
      	if @comment.destroy
          head :no_content, :status => :no_content
        else
          render json: serialize_model(@comment.errors)
        end
      end

      def update
        if @comment.update_attributes(comment_params)
          render json: serialize_model(@comment), :status => :accepted
        else
          render json: { :errors => @comment.errors }, :status => :bad_request
        end
      end

    private
    	
    	def comment_params
    		params.require(:comment).permit(:text, :picture_id)
    	end

      def get_comment
        @comment = Comment.where(id: params[:id]).first
      end

      def check_login
        unless current_user
          render nothing: true, status: :unauthorized
        end
      end
    end
  end
end
