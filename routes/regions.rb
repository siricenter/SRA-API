module Sinatra
    module API
        module Routing
            module Regions
            
                def self.registered(app)
                
                    #Retreives all regions
                    app.get '/regions' do
						@regions = Region.all#.as_json(include: {:areas => {include: {:households => {include: [{:people => {include: :jobs}},{:interview => {include: :consumed_foods}}]}}}}).to_json
						rabl :regions, format: :json
                    end
                    
                    #Create a region
                    app.post '/regions' do
                        region = Region.create(params[:region])
                        {id: region.id}.to_json
                    end
                    
                    #Retreive a region
                    app.get '/regions/:id' do
						@region = Region.find(params[:id])#.to_json
						rabl :region, format: :json
                    end
                    
                    #Update a Region
                    app.put '/regions/:id' do
                        Region.find(params[:id]).update(params[:region]).to_json
                    end
                    
                    #Delete a region
                    app.delete '/regions/:id' do
                        Region.find(params[:id]).destroy
                    end
                    
                end
            
            end
        end
    end
end