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
	VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i

	validates :name, presence: true, length:  { maximum: 50 }

	validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }

	validates :username, presence: true, format: VALID_USERNAME_REGEX, uniqueness: { case_sensitive: false }, length: { maximum: 20 }

	validates :password, length: { minimum: 6 }
	
	has_secure_password
	
	

	# associations
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	has_many :mentions
	has_many :micropost_mentions, through: :mentions, source: :micropost




	# Class methods
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end




	# instance methods

	def feed
		Micropost.from_followed_or_mentions(self)
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
	before_save { username.downcase! }
	before_create :create_remember_token


	# Private methods
	private

		def create_remember_token

			self.remember_token = User.digest(User.new_remember_token)
			
		end




end
























