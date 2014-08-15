class CreateAreasUsersTable < ActiveRecord::Migration
  def change
	  create_table :areas_users do |t|
		  t.references :area
		  t.references :user
	  end
  end
end
