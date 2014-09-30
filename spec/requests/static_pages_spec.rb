require 'spec_helper'

describe "Static pages" do

	

	

	# Describe Home Page -------------------------------------------------
	
	describe "Home page" do
		
		it "should have the content 'Sample App'" do

			visit '/static_pages/home'
			expect(page).to have_content('Sample App')

		end

	end

	# End Describe Home Page ---------------------------------------------



	# Describe Help Page -------------------------------------------------

	describe "Help page" do

		it "should have the content 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end
		
	end
	
	# End Describe Help Page ---------------------------------------------




	
end