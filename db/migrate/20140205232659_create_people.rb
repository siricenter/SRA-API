class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :given_name
      t.string :family_name
	  t.references  :family_relationship
      t.date :birthday
      t.string :education_level
      t.string :gender
      t.string :education_level
      t.boolean :in_school
      t.boolean :is_alive

      t.timestamps
    end
  end
end
