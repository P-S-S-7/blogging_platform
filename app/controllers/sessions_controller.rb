class SessionsController < ApplicationController
	def create
		user = User.find_by(:email => params[:email])
		if user
			if user.authenticate(params[:password])
				session[:user_id] = user.id
				flash[:notice] = "Logged in successfully."
				redirect_to blogs_path
			else
				flash.now[:alert] = "Invalid password.Please check again."
				render :new, status: :unprocessable_entity
			end
		else
			flash[:alert] = "User with the email does not exist.Please sign-up."
			redirect_to new_user_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logged out successfully."
		redirect_to root_path
	end
end
