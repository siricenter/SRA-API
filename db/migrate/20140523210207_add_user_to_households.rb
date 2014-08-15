class AddUserToHouseholds < ActiveRecord::Migration
	def up
		change_table :households do |table|
			table.references :user
		end
	end

	def down
		change_table :households do |table|
			table.remove :user_id
		end
	end
end
