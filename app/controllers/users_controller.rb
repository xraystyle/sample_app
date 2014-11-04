class UsersController < ApplicationController

before_action :signed_in_user, only: [:edit, :update, :index]
before_action :correct_user, only: [:edit, :update]
before_action :admin_user, only: :destroy
before_action :not_for_current_users, only: [:new, :create]


	def index
		@users = User.paginate(page: params[:page])
	end
	
	def new
		@user = User.new
	end



	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
	end




	def create
		
		@user = User.new(user_params)
		if @user.save
			sign_in(@user)
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
		
	end


	def edit

		# @user = User.find(params[:id]) before filter sets @user
		
	end

	def update

		# @user = User.find(params[:id])  before filter sets @user

		if @user.update_attributes(user_params)
			flash[:success] = "User info successfully updated"
			redirect_to @user
		else
			render 'edit'
		end
		
	end

	def destroy
		
		# User.find(params[:id]).destroy
		@user_to_delete = User.find(params[:id])

		if @user_to_delete.id == current_user.id 
			# Don't delete yourself.
			redirect_to users_path and return
		end

		@user_to_delete.destroy
		flash[:success] = "User deleted."
		redirect_to users_url
		
	end



# Private methods -------------------------------

	private

	def user_params

		params.require(:user).permit(:name, :email, :password, :password_confirmation)
		
	end


	# before filters

	def signed_in_user

		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in." unless signed_in?
		end
		
	end

	def not_for_current_users
		redirect_to root_url if signed_in?
	end


	def correct_user
		@user = User.find(params[:id])
		redirect_to root_url unless current_user?(@user)
	end

	def admin_user
		redirect_to root_url unless current_user.admin?
	end

	
end












