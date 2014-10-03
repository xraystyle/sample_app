require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

	subject { page }

	# Describe Home Page -------------------------------------------------
	
	describe "Home page" do
		before { visit root_path }

		it { should have_content('Sample App') }
		it { should have_title(full_title('')) }
		it { should_not have_title('| Home') }

	end

	# End Describe Home Page ---------------------------------------------


	# Describe Help Page -------------------------------------------------

	describe "Help page" do
		before { visit help_path }

		it { should have_content('Help') }
		it { should have_title(full_title('Help')) }
		
	end

	# End Describe Help Page ---------------------------------------------


	# Describe About Page -------------------------------------------------

	describe "About page" do
		before { visit about_path }

		it { should have_content('About Us') }
		it { should have_title(full_title('About Us')) }
		
	end

	# End Describe About Page ---------------------------------------------




	# Describe Contact Page -------------------------------------------------


	describe "Contact Page" do
		before { visit contact_path }

		it { should have_content('Contact Us') }
		it { should have_title(full_title('Contact Us')) }
		
	end


	# End Contact About Page ---------------------------------------------













	
end