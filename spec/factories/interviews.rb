FactoryGirl.define do
	factory :interview do
		household
		roof 'tin'
		wall 'stucco'
		floor 'wood'
		bedroom_count 2
		separate_kitchen true
		light 'lantern'
		fuel_type 'gas'
		water_source 'river'
		water_chlorinated true
		bathroom 'outhouse'
		sewage 'septic'
		total_income 1500
		income_unit 'pesos'
		shoe_cost 25
		shoe_unit 'pesos'
		medicine_cost 75
		medicine_unit 'pesos'
		school_cost 100
		school_unit 'pesos'
		college_cost 1000
		college_unit 'pesos'
		water_electric_cost 10
		water_electric_unit 'pesos'
		misc_cost 0
		misc_unit 'pesos'
		radio true
		tv true
		refrigerator false
		consumed_foods {[FactoryGirl.build(:consumed_food)]}
	end
end
