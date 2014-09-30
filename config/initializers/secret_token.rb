# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# SampleApp::Application.config.secret_key_base = '17a3a0cd3f268e2b6eeb6f4d0e4e1dcf1e964cfbe569138a4b8f7b4d45817a981b943aacceea0a7a7f5766904a1b30760c7b55eb21c41f1b6aecaf0316708c20'


def secure_token
	# set path to token file.
	token_file = Rails.root.join('.secret')

	# if exists, use it.
	if File.exist?(token_file)
		File.read(token_file).chomp

	else
		# make a new one.
		token = SecureRandom.hex(64)
		File.write(token_file, token)
		token
	end

end


SampleApp::Application.config.secret_key_base = secure_token