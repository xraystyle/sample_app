class ReAddIndicesToMentionsTableWithoutUniqueConstraint < ActiveRecord::Migration
	def change
		add_index :mentions, :micropost_id
		add_index :mentions, :user_id
	end
end
