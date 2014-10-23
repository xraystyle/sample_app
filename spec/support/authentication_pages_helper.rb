# Helper methods for authentication_pages_spec to separate tests from implementation.

def valid_signin(user)

	fill_in "Email",	with: user.email
	fill_in "Password",	with: user.password	
	click_button "Sign in"
	
end

def signin_with_invalid_email(user)

	fill_in "Email",	with: "bogusemail@example.net"
	fill_in "Password",	with: user.password	
	click_button "Sign in"
	
end

def signin_with_invalid_password(user)

	fill_in "Email",	with: user.email
	fill_in "Password",	with: "not the account password"	
	click_button "Sign in"
	
end