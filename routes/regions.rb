module Sinatra
    module API
        module Routing
            module Roles
            
                def self.registered(app)
                
                    #Retreives all regions
                    app.get '/regions' do
                        Region.all.to_json
                    end
                    
                    #Create a region
                    app.post '/regions' do
                        region = Region.create(params[:region])
                        {id: region.id}.to_json
                    end
                    
                    #Retreive a region
                    app.get '/regions/:id' do
                        Region.find(params[:id]).to_json
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