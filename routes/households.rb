module Sinatra
    module API
        module Routing
            module Households
            
                def self.registered(app)
                    
                    #Retreive all households
                    app.get '/households' do
						@households = Household.all #as_json(include:[{:people => {include: :jobs}},{:interview => {include: :consumed_foods}}]).to_json
						rabl :households, format: :json
					end

                    #Create a Household
                    app.post '/households' do
						houshold = Household.find_by(:name, params[:household][:name])
						if household.blank?
							{id: Household.create!(params[:household]).to_param}.to_json
					    else
							if household.people == params[:household][:people]
								return "{error:[message:'resource already exists']}"
							else
							    {id: Household.create!(params[:household]).to_param}.to_json
							end
						end
                    end

                    #Retreive a household
                    app.get '/households/:id' do
						@household = Household.find(params[:id])
						rabl :household, format: :json
                    end

                    #Update a household
                    app.put '/households/:id' do
                        household = Household.find(params[:id])
                        household.update(params[:household])
                    end

                    #Delete a household
                    app.delete '/households/:id' do
                        Household.find(params[:id]).destroy
                    end
                                        
                end
            
            end
        end
    end
end