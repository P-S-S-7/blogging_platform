class BlogsController < ApplicationController
	before_action :authenticate_user!, only: %i[new create edit update destroy]
	before_action :set_blog, only: %i[show edit update destroy]
	before_action :validate_user, only: %i[edit destroy]

	def index
		@blogs = Blog.all
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = current_user.blogs.new(blog_params)

		begin
			@blog.save!
			flash[:notice] = "Blog is successfully created."
			redirect_to @blog
		rescue ActiveRecord::RecordInvalid => e
			flash.now[:alert] = e.record.errors.full_messages
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@blog_comments = @blog.blog_comments.includes(:user)
		@blog_comment = BlogComment.new
	end

	def update
		begin
			@blog.update!(blog_params)
			flash[:notice] = "Blog is successfully updated."
			redirect_to @blog
		rescue ActiveRecord::RecordInvalid => e
			flash.now[:alert] = e.record.errors.full_messages
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
	end

	private

	def set_blog
		@blog = Blog.find(params[:id])
	rescue ActiveRecord::RecordNotFound => e
		flash[:alert] = 'Blog not found'
		redirect_to blogs_path
		return
	end

	def validate_user
		if @blog.user != current_user
			flash[:alert] = "You are not authorized to #{action_name} this blog"
			redirect_to blogs_path
		else
			if action_name == 'destroy' && @blog.destroy
				flash[:notice] = "Blog was successfully deleted."
				redirect_to blogs_path
			end
		end
	end

	def blog_params
		params.require(:blog).permit(:title, :description)
	end
end
