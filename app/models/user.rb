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
	

	# associations
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower




	# Class methods
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end




	# instance methods

	def feed
		Micropost.from_users_followed_by(self)
	end


	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end


	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end


	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user).destroy
	end


	# Callbacks
	before_save { email.downcase! }
	before_create :create_remember_token


	# Private methods
	private

		def create_remember_token

			self.remember_token = User.digest(User.new_remember_token)
			
		end




end
























