class User < ActiveRecord::Base

	# validates hash options:
	# validates :attribute,
	#     			:presence => boolean,
	#     			:numericality => boolean,
	#     			:length => {:within => 0..10},
	#     			:format => regex,
	#     			:inclusion => {:in => [array_or_range]},
	#     			:exclusion => {:in => [array_or_range]},
	#     			:acceptance => boolean,
	#     			:uniqueness => boolean,
	#     			:confirmation => boolean

	# Validations
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :name, presence: true, length:  { maximum: 50 }

	validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }

	




	# Callbacks
	before_save { email.downcase! }

end
