module InterviewDSL 
	def self.included base
		base.class_eval do
			def self.define_nutrients *nutrients
				nutrients.each do |nutrient|
					define_method("#{nutrient}") do
						aggregate_nutrient nutrient.to_s
					end
				end
			end
		end
	end

	def aggregate_nutrient nutrient
		amount = 0
		self.consumed_foods.each do |food|
			amount += food.send(nutrient)
		end

		return amount
	end

end
