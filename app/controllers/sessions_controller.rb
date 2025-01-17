class SessionsController < ApplicationController
	def create
		user = User.find_by(:email => params[:email])
		if user&.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to blogs_path, notice: "Logged in successfully."
		else
			flash[:alert] = "Invalid email or password"
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "Logged out successfully."
	end
end
