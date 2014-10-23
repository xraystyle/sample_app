module SessionsHelper

	def sign_in(user)

		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
		
	end
	

	def signed_in?
		!current_user.nil?
	end




	def current_user=(user)
		@current_user = user
	end	



	def current_user

		if cookies[:remember_token]		
			# puts "Found remember_token cookie. Searching db for #{User.digest(cookies[:remember_token])}" unless @current_user
			remember_token = User.digest(cookies[:remember_token])
			@current_user ||= User.find_by(remember_token: remember_token)
		else
			# puts "remember_token cookie not found."
			nil
		end

		# remember_token = User.digest(cookies[:remember_token])
		# @current_user ||= User.find_by(remember_token: remember_token)
		# puts "Current user is \"#{@current_user.name}\""
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	
end
