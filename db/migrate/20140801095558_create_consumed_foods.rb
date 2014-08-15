class CreateConsumedFoods < ActiveRecord::Migration
  def change
    create_table :consumed_foods do |t|
      t.references :interview
      t.string :n_id
      t.integer :servings
      t.string :frequency

      t.timestamps
    end
    add_index :consumed_foods, :interview_id
  end
end
