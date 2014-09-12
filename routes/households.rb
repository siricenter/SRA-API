module Sinatra
    module API
        module Routing
            module Households
            
                def self.registered(app)
                    
                    #Retreive all households
                    app.get '/households' do
						Household.all.as_json(include:[{:people => {include: :jobs}},{:interview => {include: :consumed_foods}}]).to_json
                    end

                    #Create a Household
                    app.post '/households' do
                        {id: Household.create!(params[:household]).to_param}.to_json
                    end

                    #Retreive a household
                    app.get '/households/:id' do
                        Household.find(params[:id]).to_json
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