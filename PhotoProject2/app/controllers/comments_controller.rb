class CommentsController < ApplicationController
  include SerializerModule

  before_action :get_comment, only: [:destroy, :update] 

	def create
		@comment = Comment.new(comment_params.merge(:user_id => current_user.id))
    if @comment.save
      render json: serialize_model(@comment)
    else
      render json: @comment.errors
    end
	end

	def destroy
  	if @comment.destroy
      head :no_content
    else
      render json: serialize_model(@comment.errors)
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      render json: serialize_model(@comment)
    else
      render json: @comment.errors
    end
  end

private
	
	def comment_params
		params.require(:comment).permit(:text, :picture_id)
	end

  def get_comment
    @comment = Comment.where(id: params[:id]).first
  end
end
