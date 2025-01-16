class BlogsController < ApplicationController
	before_action :set_blog, only: %i[show edit update destroy]

	def index
		@blogs = Blog.all
	end

	def new
		@blog = Blog.new
	end

	def create
		user = user_check

		@blog = Blog.get_new(blog_params[:title], blog_params[:description], user.id)

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
		user = user_check

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
		rescue ActiveRecord::RecordNotFound => e
			flash[:alert] = 'Blog not found'
			redirect_to blogs_path
	end

	def blog_params
		params.require(:blog).permit(:title, :description, :email, :name)
	end

	def user_check
		user = User.find_by(email: blog_params[:email])
		user ||= User.create(email: blog_params[:email], name: blog_params[:name])

		user
	end
end

