class Micropost < ActiveRecord::Base

	# validations
	validates :user_id, presence: true


	# associations
	belongs_to :user





end
