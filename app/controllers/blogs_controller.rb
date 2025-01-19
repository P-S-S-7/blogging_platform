class BlogsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_blog, only: %i[show edit update destroy]

	def index
		@blogs = Blog.all
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = current_user.blogs.new(blog_params)

		if @blog.save!
			flash[:notice] = "Blog was successfully created."
			redirect_to @blog
		else
			flash.now[:alert] = @blog.errors.full_messages.join(", ")
			render :new, status: :unprocessable_entity
		end
	end

	def show
		redirect_to blogs_path unless @blog.user == current_user
	end

	def edit
	end

	def update
		if @blog.user == current_user && @blog.update(blog_params)
			flash[:notice] = "Blog was successfully updated."
			redirect_to @blog
		else
			flash.now[:alert] = @blog.errors.full_messages.join(", ")
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		if @blog.user == current_user
			@blog.destroy!
			flash[:notice] = "Blog was successfully deleted."
		else
			flash[:alert] = "Not authorized"
		end

		redirect_to blogs_path
	end

	private

	def set_blog
		@blog = Blog.find(params[:id])
		rescue ActiveRecord::RecordNotFound => e
			flash[:alert] = 'Blog not found'
			redirect_to blogs_path
	end

	def blog_params
		params.require(:blog).permit(:title, :description)
	end
end
