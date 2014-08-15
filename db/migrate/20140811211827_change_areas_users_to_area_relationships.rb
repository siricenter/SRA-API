class ChangeAreasUsersToAreaRelationships < ActiveRecord::Migration
  def up
      rename_table :areas_users, :area_relationships
  end

  def down
      rename_table :area_relationships, :areas_users
  end
end
