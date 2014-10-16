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
		let(:submit) { "Sign in" }

		describe "with an invalid email address" do

			before do
				fill_in "Email",			with: "notmichael@example.com"
				fill_in "Password",			with: user.password
			end

			it "should not successfully sign in" do
				before { click_button submit }
				it { should have_title('Sign in') }
				it { should have_selector('div.alert.alert-error') }
			end
			

		end

		describe 'with an invalid password' do
			
			before do
				fill_in "Email",			with: user.email
				fill_in "Password",			with: "notfoobar"
			end

			it "should not successfully sign-in" do
				before { click_button submit }
				it { should have_title('Sign in') }
				it { should have_selector('div.alert.alert-error') }
			end


		end

		describe 'with valid credentials' do
			
			before do
				fill_in "Email",			with: user.email
				fill_in "Password",			with: user.password
			end		

			it 'should successfully sign in' do
				before { click_button submit }				
				it { should have_title(user.name) }
				it { should have_content(user.name) }
				it { should have_xpath("//img[@alt=\"#{user.name}\"]") }
			end




		end

		
	end


end


















