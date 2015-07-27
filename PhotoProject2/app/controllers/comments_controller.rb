class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params.merge(:user_id => current_user.id))

		respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comentariul a fost adaugat' }
        format.json { render json: serialize_model(@comment) }
      else
        format.html { redirect_to :back, notice: 'Commentariul nu a putut fi adaugat' }
        format.json { render json: serialize_model(@comment.errors) }
      end
    end
	end

	def destroy
		@comment = Comment.find(params[:id])

  	respond_to do |format|
  		if @comment.destroy
        format.html { redirect_to :back, notice: 'Comentariul a fost sters' }
        format.json { head :no_content}
      else
        format.html { render :back, notice: 'Comentariul nu poate fi sters' }
        format.json { render json: serialize_model(@comment.errors) }
      end
    end
  end

private
	
	def comment_params
		params.require(:comment).permit(:text, :picture_id)
	end
end
