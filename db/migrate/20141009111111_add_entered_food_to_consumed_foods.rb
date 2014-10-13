class AddEnteredFoodToConsumedFoods < ActiveRecord::Migration
	def up
        add_column :consumed_foods, :entered_food, :string
	end

	def down
        remove_column :consumed_foods, :entered_food
	end
end
