require 'spec_helper'

describe "Static pages:" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

	subject { page }

	# Shared tests for all static pages ----------------------------------
	shared_examples_for "all static pages" do
	
		it { should have_selector('h1', text: heading) }
		it { should have_title(full_title(page_title)) }

	end
	# End shared tests for all static pages -------------------------------




	# Describe Home Page -------------------------------------------------
	
	describe "Home page" do

		let(:user) { FactoryGirl.create(:user) }

		describe 'for logged out users' do

			before { visit root_path }

			let(:heading)		{ 'Sample App' }
			let(:page_title)	{ '' }

			it_should_behave_like "all static pages"
			it { should_not have_title('| Home') }
			it { should have_css('div.center.hero-unit') }

		end

		describe 'for logged in users' do
			before do

				rand(15..40).times do # make a random number of posts.
					FactoryGirl.create(:micropost, user: user, content: Faker::Lorem.sentence(5))
				end
				# make two posts with known/expected content.
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum") 
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in(user)
				visit root_path

			end
			
			let(:feed) { user.feed }

			it "should render the user's feed" do
				feed.each_with_index do |item, index|
					if index <= 29
						expect(page).to have_selector("li##{item.id}", text: item.content)
					end
				end
			end

			it "should have no more than 30 microposts per page" do
				within("ol.microposts") do
					if feed.count > 30 
						page.should have_css("li", count: 30) # no more than 30 per page.
					else
						# if less than 30, total number of posts should match displayed.
						page.should have_css("li", count: user.microposts.count)
					end
				end

				if feed.count > 30 # more than 30 items should paginate.
					page.should have_selector("div.pagination")
				else
					page.should_not have_selector("div.pagination")
				end

			end

			it { should have_selector("span", text: "#{user.microposts.count} #{"micropost".pluralize(user.microposts.count)}") }
			it { should_not have_css('div.center.hero-unit') }
			it { should have_field('micropost_content') }
			
		end


	end

	# End Describe Home Page ---------------------------------------------


	# Describe Help Page -------------------------------------------------

	describe "Help page" do
		before { visit help_path }

		let(:heading)		{ 'Help' }
		let(:page_title)	{ 'Help' }

		it_should_behave_like "all static pages"
		
	end

	# End Describe Help Page ---------------------------------------------


	# Describe About Page -------------------------------------------------

	describe "About page" do
		before { visit about_path }

		let(:heading)		{ 'About Us' }
		let(:page_title)	{ 'About Us' }

		it_should_behave_like "all static pages"
		
	end

	# End Describe About Page ---------------------------------------------




	# Describe Contact Page -------------------------------------------------


	describe "Contact Page" do
		before { visit contact_path }

		let(:heading)		{ 'Contact' }
		let(:page_title)	{ 'Contact Us' }

		it_should_behave_like "all static pages"
		
	end


	# End Contact Page -----------------------------------------------------


	# Describe Correct Links on Layout --------------------------------------

	it "should have the right links on the layout" do
		visit root_path

		click_link "About"
		expect(page).to have_title(full_title('About Us'))
		click_link "Help"
		expect(page).to have_title(full_title('Help'))
		click_link "Contact"
		expect(page).to have_title(full_title('Contact Us'))
		click_link "Home"
		click_link "Sign Up Now!"
		expect(page).to have_title(full_title('Sign Up'))
		click_link "sample app"
		expect(page).to have_title(full_title(''))


	end




	# End describe Correct Links on Layout -----------------------------------













	
end