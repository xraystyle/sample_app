class Micropost < ActiveRecord::Base

	# validations
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }


	# associations
	belongs_to :user
	has_many :mentions
	has_many :mentioned_users, through: :mentions, source: :user


	# scopes
	default_scope -> { order('created_at DESC') }

	
	# Callbacks
	after_save { check_for_mentions }


	# class methods:

	def self.from_followed_or_mentions(user)
		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		mentioning_current_user = "SELECT micropost_id from mentions WHERE user_id = :user_id"
		mentioning_followed_users = "SELECT micropost_id FROM mentions WHERE user_id IN (SELECT followed_id FROM relationships WHERE follower_id = :user_id)"
		
		where("user_id IN (#{followed_user_ids}) 
				OR user_id = :user_id 
				OR id IN (#{mentioning_current_user}) 
				OR id IN(#{mentioning_followed_users})", user_id: user)
	end


	private


		def check_for_mentions
			mentions_regex = /@([A-Za-z0-9_-]+)/
			mentioned_usernames = self.content.scan(mentions_regex)
			
			mentioned_usernames.each do |username|
				
				create_mention(username)

			end

		end


		def create_mention(username)

			user = User.where(username: username).first

			if user
				Mention.create!(user_id: user.id, micropost_id: self.id) unless user == self.user
			end
			
		end



end















