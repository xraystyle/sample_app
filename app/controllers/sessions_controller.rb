class SessionsController < ApplicationController

	def new
		
	end

	def create
		
		user = User.find_by(email: params[:email].downcase)
		if user && user.authenticate(params[:password])
			# log in the user and redirect to profile page.
			# p user
			# flash[:success] = "Login successful."
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
		sign_out
		redirect_to root_url
	end

	



	# private methods
	private




end
























