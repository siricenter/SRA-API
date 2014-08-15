class AddHouseholdIdToPeople < ActiveRecord::Migration
  def change
	  change_table :people do |people|
		  people.references :household
	  end
  end
end
