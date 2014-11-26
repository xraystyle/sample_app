class RemoveIndicesFromMentionsTable < ActiveRecord::Migration
	def change
		remove_index :mentions, :micropost_id
		remove_index :mentions, :user_id
	end
end
