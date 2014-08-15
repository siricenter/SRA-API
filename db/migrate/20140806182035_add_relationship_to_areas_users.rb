class AddRelationshipToAreasUsers < ActiveRecord::Migration
  def change
    add_column :areas_users, :relationship, :string
  end
end
