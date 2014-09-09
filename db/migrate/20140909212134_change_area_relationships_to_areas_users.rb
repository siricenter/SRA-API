class ChangeAreaRelationshipsToAreasUsers < ActiveRecord::Migration
  def up
      rename_table :area_relationships, :areas_users
  end

  def down
      rename_table :areas_users, :area_relationships
  end
end
