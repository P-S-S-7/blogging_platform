class BlogsController < ApplicationController
	before_action :set_blog, only: %i[show edit update destroy]
	before_action :requires_login, except: %i[index]

	def index
		@blogs = Blog.all
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new(blog_params.merge(user: current_user))

		begin
			@blog.save!
			flash[:notice] = "Blog was successfully created."
			redirect_to @blog
		rescue ActiveRecord::RecordInvalid => e
			flash.now[:alert] = e.record.errors.full_messages
			render :new, status: :unprocessable_entity
		end
	end

	def show
		if @blog.user != current_user
			flash[:alert] = "You are not authorized to view this blog."
			redirect_to blogs_path 
		end
	end

	def edit
		if @blog.user != current_user
			flash[:alert] = "You are not authorized to edit this blog."
			redirect_to blogs_path
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
			end
		else
			flash[:alert] = "You are not authorized to update this blog."
			redirect_to blogs_path
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
	rescue ActiveRecord::RecordNotFound
		flash[:alert] = "Blog not found."
		redirect_to blogs_path
	end

	def blog_params
		params.require(:blog).permit(:title, :description)
	end

	def requires_login
		if !current_user
			flash[:alert] = "You must be logged in to perform this action."
			redirect_to login_path
		end
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end
	helper_method :current_user
end
