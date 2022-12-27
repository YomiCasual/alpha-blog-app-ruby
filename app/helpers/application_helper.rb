module ApplicationHelper

	def pluralizeWorld(n, singular, plural=nil)
		if n == 1
			"1 #{singular}"
		elsif plural
			"#{n} #{plural}"
		else
			"#{n} #{singular}s"
		end
	end

	def is_loggedin_user?(id)
		if get_current_user 
			get_current_user["id"] === id
		end
	end

end
