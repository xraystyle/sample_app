# Helper methods for authentication_pages_spec to separate tests from implementation.

def fill_in_valid_info
	fill_in "Name",						with: 	"Example User"
	fill_in "Email", 					with: 	"user@example.com"
	fill_in "Password", 				with: 	"foobar"
	fill_in "Confirmation", 			with: 	"foobar"
end

