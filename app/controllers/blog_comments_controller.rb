class BlogCommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment, only: [:destroy]

	def create
		@blog = Blog.find(params[:blog_id])
		@blog_comment = @blog.blog_comments.new(comment_params)
		@blog_comment.user = current_user

		begin @blog_comment.save!
			flash[:notice] = "Comment added successfully."
			redirect_to blog_path(@blog)
		rescue ActiveRecord::RecordInvalid => e
			flash.now[:alert] = e.record.errors.full_messages
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		if @blog_comment.user == current_user
			@blog_comment.destroy
			flash[:notice] = "Comment deleted successfully."
		else
			flash[:alert] = "You are not authorized to delete this comment."
		end
		redirect_to blog_path(@blog_comment.blog)
	end

	private

	def set_comment
		@blog_comment = BlogComment.find(params[:id])
	end

	def comment_params
		params.require(:blog_comment).permit(:content)
	end
end

