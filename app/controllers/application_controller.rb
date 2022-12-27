class ApplicationController < ActionController::Base


	def paginate_data(obj, options = {page: 1, size: 5})
		obj.paginate(page: params[:page] || options[:page], per_page: params[:size] || options[:size])
  	end 


	def get_current_user
		@get_current_user ||=  User.find(session[:auth_user]["id"]) if session[:auth_user]
	end
 
 
	 def is_logged_in?
		!!get_current_user
	 end

	 def is_authenticated_route
		if !is_logged_in?
			flash[:alert] = "Authentication required"
			redirect_to auth_login_path
		end
	 end

	 def redirect_unaunthenticated
		if is_logged_in?
			redirect_to articles_path
			return 
		end
	 end

	 def is_loggedin_user?(id)
		if get_current_user 
			get_current_user["id"] === id 
		end
	end


	 

	 helper_method :is_logged_in?, :is_authenticated_route, :get_current_user, :is_loggedin_user?
	
end
