class BlogsController < ApplicationController
	before_action :authenticate_user!, only: %i[new create edit update destroy show]
	before_action :set_blog, only: %i[show edit update destroy]
	before_action :requires_auth, only: %i[edit]

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

	def update
		if @blog.user == current_user
			begin
				@blog.update!(blog_params)
				flash[:notice] = "Blog is successfully updated."
				redirect_to @blog
			rescue ActiveRecord::RecordInvalid => e
				flash.now[:alert] = e.record.errors.full_messages
				render :edit, status: :unprocessable_entity
			else
				flash[:alert] = "You are not authorized to update this blog."
				redirect_to blogs_path
			end
		end
	end

	def destroy
		if @blog.user == current_user && @blog.destroy!
			flash[:notice] = "Blog is successfully deleted."
		else
			flash[:alert] = "You are not authorized to delete this blog."
		end

		redirect_to blogs_path
	end

	private

	def set_blog
		@blog = Blog.find(params[:id])
	rescue ActiveRecord::RecordNotFound => e
		flash[:alert] = 'Blog not found'
		redirect_to blogs_path
		return
	end

	def requires_auth
		if @blog.user != current_user
			flash[:alert] = "You are not authorized to perform this action"
			redirect_to blogs_path
			return
		end
	end

	def blog_params
		params.require(:blog).permit(:title, :description)
	end
end
