require 'spec_helper'
require "factory_girl_rails"

# lines marked with a 'custom' comment are defined in spec/support/user_pages_helper.rb, or in utilities.rb
describe "UserPages" do

	subject { page }


	# Describe Index Page -----------------------------------------------

	describe 'index' do
		before do
			sign_in(FactoryGirl.create(:user))
			FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
			FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
			visit users_path
		end
		
		it { should have_title('All Users') }
		it { should have_content('All Users') }


		describe 'pagination' do
			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			it { should have_selector('div.pagination') }
	
			it 'should list each user' do
				User.paginate(page: 1).each do |user|
					expect(page).to have_selector('li', text: user.name)
				end
			end

		end





	end



	# End escribe Index Page --------------------------------------------


	# Describe Signup Page -----------------------------------------------
	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Sign Up')}
		it { should have_title(full_title('Sign Up'))}
		

	end

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create my account" }


		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_title("Sign Up") }
				it { should have_content('error') }

			end

		end

		describe "with valid information" do
			before { fill_in_valid_info } # custom

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }

				let(:user) { User.find_by(email: "user@example.com") }

				it { should have_link('Sign out') }
				it { should have_title(user.name) }
				it { should have_success_message('Welcome') }
				
			end

		end

	end
	
	# End Describe Signup Page --------------------------------------------

	



	# Describe Profile Page -----------------------------------------------

	describe "profile page" do
		# make a user variable.
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content user.name }
		it { should have_title user.name }
		it { should have_xpath("//img[@alt=\"#{user.name}\"]") } 
	end



	# End Describe Profile Page -------------------------------------------




	# Describe user edit Page ---------------------------------------------

	describe 'Edit user' do
		
		let(:user) { FactoryGirl.create(:user) }
		
		before do
			sign_in(user)
			visit edit_user_path(user)
		end

		describe 'page' do

			it { should have_content("Update your profile") }
			it { should have_title('Edit user') }
			it { should have_link('change', href: "http://gravatar.com/emails") }
			
		end

		describe "with invalid information" do

			before { click_button("Save changes") }
	
			describe 'should produce an error' do
				it { should have_error_message("The form contains") }
			end
			
		end

		describe 'with valid information' do

			before { fill_in_name_change  } #custom
			# FactoryGirl creates the user with the name "Michael Hartl."
			# this method fills in "Test User as the new name."

			describe 'should update the user' do
				before { click_button "Save changes" }

				it { should have_success_message("successfully updated") }
				it { should have_title("Test User") }
				it { should have_link('Sign out', href: signout_path) }
				it { should_not have_title("Michael Hartl") }
				specify { expect(user.reload.name).to eq "Test User" }
				specify { expect(user.reload.name).not_to eq "Michael Hartl" }

			end

		end

	end












	# End Describe user edit Page -----------------------------------------














end
