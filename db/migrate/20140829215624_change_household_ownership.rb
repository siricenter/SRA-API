class ChangeHouseholdOwnership < ActiveRecord::Migration
	def up
		change_table :households do |table|
			table.remove :user_id
			table.references :area
		end
	end

	def down
		change_table :households do |table|
			table.remove :area_id
			table.references :user
		end
	end
end
