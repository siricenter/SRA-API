class CreateFamilyRelationships < ActiveRecord::Migration
  def change
    create_table :family_relationships do |t|
      t.string :name

      t.timestamps
    end
  end
end
