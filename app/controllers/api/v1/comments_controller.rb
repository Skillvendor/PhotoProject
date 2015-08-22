module Api
  module V1
    class CommentsController < Api::V1::BaseController
      before_action :signed_in?
      before_action :get_comment, only: [:destroy, :update]

      respond_to :json

    	def create
    		@comment = Comment.new(comment_params.merge(user_id: current_user.id))
        if @comment.save
          render json: serialize_model(@comment), status: :created
        else
          render json: { errors: @comment.errors }, status: :bad_request
        end
    	end

    	def destroy
      	if @comment.destroy
          head :no_content, status: :no_content
        else
          render json: serialize_model(@comment.errors)
        end
      end

      def update
        if @comment.update_attributes(comment_params)
          render json: serialize_model(@comment), status: :accepted
        else
          render json: { errors: @comment.errors }, status: :bad_request
        end
      end

    private
    	
    	def comment_params
    		params.require(:comment).permit(:text, :picture_id)
    	end

      def get_comment
        @comment = Comment.find_by_id(params[:id])
        check_owner
      end

      def signed_in?
         render json: { errors: { user: "not signed in" } }, status: :unauthorized  unless user_signed_in?
      end

      def check_owner
        render json: { errors: { user: "not the owner" } }, status: :unauthorized  unless current_user.id == @comment.user_id
      end
    end
  end
end
