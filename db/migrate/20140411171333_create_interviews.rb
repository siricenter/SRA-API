class CreateInterviews < ActiveRecord::Migration
	def change
		create_table :interviews do |t|
			t.references :household
			t.string :roof
			t.string :wall
			t.string :floor
			t.string :bedroom_count
			t.string :separate_kitchen
			t.string :light
			t.string :fuel_type
			t.string :water_source
			t.string :water_chlorinated
			t.string :bathroom
			t.string :sewage
			t.string :person_count
			t.string :total_income
			t.string :income_unit
			t.string :shoe_cost
			t.string :shoe_unit
			t.string :medicine_cost
			t.string :medicine_unit
			t.string :school_cost
			t.string :school_unit
			t.string :college_cost
			t.string :college_unit
			t.string :water_electric_cost
			t.string :water_electric_unit
			t.string :misc_cost
			t.string :misc_unit
			t.string :radio
			t.string :tv
			t.string :refrigerator

			t.timestamps
		end
	end
end
