module UsersHelper

	def gravatar_for(user, options = { size: 50 })

		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		size = options[:size]
		
		image_tag(gravatar_url, size: size, alt: user.name, class: "gravatar")
		

	end

end