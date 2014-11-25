class Micropost < ActiveRecord::Base

	# validations
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }


	# associations
	belongs_to :user
	has_many :mentions
	has_many :mentioned_users, through: :mentions, source: :user



	default_scope -> { order('created_at DESC') }


	# class methods:

	def self.from_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
	end


end















