module ConsumedFoodDSL
	def self.included base
		base.class_eval do
			def self.nutrients nutrients_hash
				nutrients_hash.each do |method_name, api_key|
					define_method(method_name.to_s) do
						servings_of(get_data[api_key])
					end
				end
			end
		end
	end

	def is_cached
		!(@data.nil?)
	end

	def get_data
		unless is_cached
			app_id = "f67bfd42"
			app_key = "c69bd76b98dd8d4e1fd629241b3bb199"
			json = Nutritionix::API.new(app_id, app_key, "https://api.nutritionix.com/v1/").get_item(self.n_id)
			@data = JSON.parse(json)
		end
		return @data
	end

	def servings_of amount
		amount *= self.servings

		if self.frequency == 'daily'
			amount
		elsif self.frequency == 'weekly'
			amount / 7
		elsif self.frequency == 'monthly'
			amount / 30
		end
	end
end

