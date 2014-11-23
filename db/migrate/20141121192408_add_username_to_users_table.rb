class AddUsernameToUsersTable < ActiveRecord::Migration
	def change

		add_column :users, :username, :string

	end

	add_index :users, :username, unique: true

end
