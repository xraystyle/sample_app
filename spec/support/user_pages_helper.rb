# Helper methods for authentication_pages_spec to separate tests from implementation.

def fill_in_valid_info
	fill_in "Name",						with: 	"Example User"
	fill_in "Email", 					with: 	"user@example.com"
	fill_in "Username",					with: 	"example-1"
	fill_in "Password", 				with: 	"foobar"
	fill_in "Confirmation", 			with: 	"foobar"
end

def fill_in_name_change

	visit edit_user_path(user)
	fill_in "Name",						with: "Test User"
	fill_in "Password", 				with: 	"foobar"
	fill_in "Confirmation", 			with: 	"foobar"

end
