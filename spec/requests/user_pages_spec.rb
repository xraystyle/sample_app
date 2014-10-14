require 'spec_helper'

describe "UserPages" do

	subject { page }



	# Describe Signup Page -----------------------------------------------
	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Sign Up')}
		it { should have_title(full_title('Sign Up'))}

	end
	
	# End Describe Signup Page --------------------------------------------

	



	# Describe Profile Page -----------------------------------------------

	describe "profile page" do
		# make a user variable.
		let(:user) { User.first }
		before { visit user_path(user) }

		it { should have_content user.name }
		it { should have_content user.email }

	end



	# End Describe Profile Page -------------------------------------------

end
