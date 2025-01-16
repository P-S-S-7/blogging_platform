class BlogsController < ApplicationController
	before_action :set_blog, only: %i[show edit update destroy]

	rescue_from ActiveRecord::RecordNotFound, with: :blog_not_found

	def index
		@blogs = Blog.all
	end

	def new
		@blog = Blog.new
	end

	def create
		user = User.find_by(email: blog_params[:email])

		if user.nil?
			user = User.create(email: blog_params[:email], name: blog_params[:name])
		end

		@blog = Blog.create(blog_params[:title], blog_params[:description], user.id)

		if @blog.save!
			redirect_to @blog
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
	end

	def edit
	end

	def update
		user = User.find_by(email: blog_params[:email])

		if user.nil?
			user = User.create(email: blog_params[:email], name: blog_params[:name])
		end

		if @blog.update({:title => blog_params[:title], :description => blog_params[:description], :user_id => user.id})
			redirect_to @blog
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@blog.destroy
		redirect_to blogs_path
	end

	private

	def set_blog
		@blog = Blog.find(params[:id])
	end

	def blog_params
		params.require(:blog).permit(:title, :description, :email, :name)
	end

	def blog_not_found
		flash[:alert] = 'Blog not found'
		redirect_to blogs_path
	end
end

