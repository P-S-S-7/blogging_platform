class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		begin
			@user.save!
			session[:user_id] = @user.id
			flash[:notice] = "Account created successfully."
			redirect_to root_path
		rescue ActiveRecord::RecordInvalid => e
			flash.now[:alert] = e.record.errors.full_messages
			render :new, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end
end
