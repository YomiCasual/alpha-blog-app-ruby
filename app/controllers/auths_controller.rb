class AuthsController < ApplicationController

	def new
		redirect_unaunthenticated
		@user = User.new
	end

	def create
		@user = User.new(**get_signup_params, avatar: 'https://i.pravatar.cc' )
		if @user.save
			session[:auth_user] = @user
			redirect_to @user, notice: "User created successfully"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def login
		redirect_unaunthenticated
		@user = User.new
	end


	def authenticate
		if get_signup_params[:email].empty? || get_signup_params[:password].empty?
			flash.now[:alert] = "No email or password"
			render :login, status: :unprocessable_entity, notice: "Email not found"
			return
		end


		@user = User.find_by(email: get_signup_params[:email].downcase )

		if !@user.present?
			flash.now[:alert] = "Invalid Credentials"
			render :login, status: :unprocessable_entity
			return
		end


		user = @user.authenticate(get_signup_params[:password])

		if user
			session[:auth_user] = user
			redirect_to root_path, notice: "User authenticated successfully"
		else
			flash.now[:alert] = "Invalid Credentials"
			render :login, status: :unprocessable_entity
		end
	end

	def destroy
		session[:auth_user] = nil
		redirect_to auth_login_path, notice: "User logged out successfully"
	end

	private
	def get_signup_params
		params.require(:user).permit(:email, :username, :description, :password, :password_confirmation)
	end



end