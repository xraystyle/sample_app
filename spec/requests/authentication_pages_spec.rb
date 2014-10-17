require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "sign-in page" do
		before { visit signin_path }

		it { should have_content('Sign In') }
		it { should have_title('Sign In') }
		
	end

	describe "sign-in" do
		let(:user) { FactoryGirl.create(:user) }
		# Factory Girl :user definition:
		# name "Michael Hartl"
		# email "michael@example.com"
		# password "foobar"
		# password_confirmation "foobar"


		before { visit signin_path }

		describe "with an invalid email address" do

			before do
			fill_in "Email",			with: "notmichael@example.com"
			fill_in "Password",			with: user.password
			click_button "Sign in"

			end

			describe "should not successfully sign in" do
				it { should have_title('Sign In') }
				it { should have_selector('div.alert.alert-error') }
			end

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end
			

		end

		describe 'with an invalid password' do
			
			before do
				fill_in "Email",			with: user.email
				fill_in "Password",			with: "notfoobar"
				click_button "Sign in"
			end

			describe "should not successfully sign-in" do
				it { should have_title('Sign In') }
				it { should have_selector('div.alert.alert-error') }
			end

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end

		end

		describe 'with valid credentials' do
			
			before do
				fill_in "Email",			with: user.email.upcase
				fill_in "Password",			with: user.password
				click_button "Sign in"
			end		

			describe 'should successfully sign in' do
				it { should have_title(user.name) }
				it { should have_content(user.name) }
				it { should have_link('Profile', href: user_path(user)) }
				it { should have_link('Sign out', href: signout_path) }
				it { should_not have_link('Sign in', href: signin_path) }
			end




		end

		
	end


end


















