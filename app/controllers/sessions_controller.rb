class SessionsController < ApplicationController

	def new
		
	end

	def create
		
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# log in the user and redirect to profile page.
			sign_in(user)
			redirect_to user
		else
			# back to login, display errors.
			flash.now[:error] = "Invalid username/password."
			render 'new'
		end

		# render 'new'
	end

	def destroy
		
	end

end
