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









	
end