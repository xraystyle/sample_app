class Micropost < ActiveRecord::Base

	# validations
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }


	# associations
	belongs_to :user

	default_scope -> { order('created_at DESC') }


end















