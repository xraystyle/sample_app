require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "description" do
		before { visit signin_path }

		it { should have_content('Sign In') }
		it { should have_title('Sign In') }
		
	end

end
