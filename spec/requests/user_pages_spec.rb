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

	


end
