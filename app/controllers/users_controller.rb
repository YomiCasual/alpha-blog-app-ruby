class UsersController < ApplicationController

	before_action :is_authenticated_route
	before_action :get_user, only: [:show, :edit, :update]
	before_action :can_perform_action?, only: [:edit, :update]

	def index
		@users = paginate_data(User, { size: 3})

	end
	def show
		get_user
	end

	def new
		@user = User.new
	end
	
	def edit
		# can_perform_action?
		render :new
	end

	def update
		
		if get_update_user[:password].empty?
			flash.now[:alert] = "No password supplied"
			render :new, status: :unprocessable_entity
			return
		end 

		user = get_user.authenticate(get_update_user[:old_password])

		if !user
			flash.now[:alert] = "Invalid credentials"
			render :new, status: :unprocessable_entity
			return
		end

		if @user.update(username: get_update_user[:username], password: get_update_user[:password])
			redirect_to @user, notice: "User updated successfully"
		else
			render :edit, status: :unprocessable_entity
		end
	end

	private 
	def get_update_user
		params.require(:user).permit(:username,  :password, :old_password)
	end

	def get_user
		@user = User.find(params[:id])
	end



end
