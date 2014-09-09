module Sinatra
    module API
        module Routing
            module Areas
            
                def self.registered(app)
                    
                    #Retreives all the areas
                    app.get '/areas' do 
                        areas = Area.all.as_json(include: {:households => {include: :people}}).to_json
                    end
                
                    #Create a new Area
                    app.post '/areas' do
                        area = Area.new(params[:area])    
                        area.save!
                        return {id: area.id}.to_json
                    end

                    #Retreive an area
                    app.get '/areas/:id' do
                        Area.find(params[:id]).to_json
                    end

                    #Updates an area
                    app.put '/areas/:id' do
                        area = Area.find(params[:id])
                        area.update(params[:area])
                        area.save
                    end
                    
                    #Destroys an area
                    app.delete '/areas/:id' do
                        area = Area.find(params[:id])
                        area.destroy
                    end
                    
                end
            
            end
        end
    end
end