class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment, only: [:destroy]

	def create
		@blog = Blog.find(params[:blog_id])
		@comment = @blog.comments.new(comment_params)
		@comment.user = current_user

		begin @comment.save!
			flash[:notice] = "Comment added successfully."
			redirect_to blog_path(@blog)
		rescue ActiveRecord::RecordInvalid => e
			flash.now[:alert] = e.record.errors.full_messages
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		if @comment.user == current_user
			@comment.destroy
			flash[:notice] = "Comment deleted successfully."
		else
			flash[:alert] = "You are not authorized to delete this comment."
		end
		redirect_to blog_path(@comment.blog)
	end

	private

	def set_comment
		@comment = Comment.find(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:content)
	end
end

