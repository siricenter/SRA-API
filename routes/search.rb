require "nutritionix/api_1_1"

module Sinatra
    module API
        module Routing
            module Search
                def self.registered(app)
					app.post '/search' do
					app_id = "f67bfd42"
					api_key = "c69bd76b98dd8d4e1fd629241b3bb199"
					query = params[:query]
					provider = Nutritionix::Api_1_1.new(app_id, api_key)
					search_params = {
						offset: 0,
						limit: 1,
						fields: ['brand_id', 'brand_name', 'item_id', 'item_name', 'nf_calories'],
						filters: {
							item_type: 3
						},
						query: query,
						}
					@results_json = provider.nxql_search(search_params)
				    end
                end
            end
        end
    end
end