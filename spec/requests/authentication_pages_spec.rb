require 'spec_helper'

# lines marked with a 'custom' comment are defined in spec/support/authentication_helper.rb or utilities.rb

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

			before { signin_with_invalid_email(user) } # custom

			describe "should not successfully sign in" do
				it { should have_title('Sign In') }
				it { should have_error_message("Invalid") } # custom
				it { should_not have_link('Settings', href: edit_user_path(user)) }
				it { should_not have_link('Users', href: users_path) }
			end

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_link('Settings', href: edit_user_path(user)) }
				it { should_not have_error_message("Invalid") }  # custom
				it { should_not have_link('Users', href: users_path) }
			end
			

		end

		describe 'with an invalid password' do
			
			before { signin_with_invalid_password(user) } # custom

			describe "should not successfully sign-in" do
				it { should have_title('Sign In') }
				it { should_not have_link('Settings', href: edit_user_path(user)) }
				it { should_not have_link('Users', href: users_path) }
				it { should have_error_message("Invalid") } # custom
			end

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_link('Settings', href: edit_user_path(user)) }
				it { should_not have_link('Users', href: users_path) }
				it { should_not have_error_message("Invalid") } # custom
			end

		end

		describe 'with valid credentials' do
			
			before { sign_in(user) } # custom
				

			describe 'should successfully sign in' do
				it { should have_title(user.name) }
				it { should have_content(user.name) }
				it { should have_link('Users', href: users_path) }
				it { should have_link('Profile', href: user_path(user)) }
				it { should have_link('Settings', href: edit_user_path(user)) }
				it { should have_link('Sign out', href: signout_path) }
				it { should_not have_link('Sign in', href: signin_path) }
			end

			describe "followed by sign out" do
				before {click_link 'Sign out'}
				it {should have_link('Sign in')}
			end


		end

	end

	describe 'authorization' do
		# let(:user) { FactoryGirl.create(:user) }

		describe 'for non-signed-in users' do
			let(:user) { FactoryGirl.create(:user) }

			describe 'when attempting to visit a protected page' do
				before do
					visit edit_user_path(user)
					fill_in "Email",	with: user.email
					fill_in "Password",	with: user.password
					click_button "Sign in"
				end

				describe 'after signing in' do

					it 'should render the desired protected page' do
						expect(page).to have_title("Edit user") 
					end
					
				end

				
			end



			describe 'in the Users controller' do
				
				describe 'visiting the edit page' do
					before { visit edit_user_path(user) }

					it { should have_title('Sign In') }
				end

				describe 'submitting to the update action' do
					before { patch user_path(user) }

					specify { expect(response).to redirect_to(signin_path) }
				end

				describe 'visiting the user index' do
					before { visit users_path }

					it { should have_title('Sign In') }
				end

				
			end
			
		end

		describe 'as the wrong user' do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
			before { sign_in(user, no_capybara: true) }


			describe 'submitting a GET request to the Users#edit action' do
				before { get edit_user_path(wrong_user) }

				specify { expect(response.body).not_to match(full_title('Edit user')) }
				specify { expect(response).to redirect_to(root_url) }
			end


			describe 'submitting a PATCH request to the Users#update action' do
				before { patch user_path(wrong_user) }

				specify { expect(response).to redirect_to(root_url) }
			end

			
		end
		
	end


end


















