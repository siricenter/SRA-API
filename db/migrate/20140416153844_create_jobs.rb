class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.boolean :seasonal
      t.string :description
	  t.references :person
	  t.references :occupation

      t.timestamps
    end
  end
end
