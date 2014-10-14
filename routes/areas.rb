module Sinatra
    module API
        module Routing
            module Areas
            
                def self.registered(app)
                    
                    #Retreives all the areas
                    app.get '/areas' do
                        @areas = Area.all
                        rabl :areas, format: :json
						#areas = Area.all.as_json(include: [{:households => {include: [{:people => {include: :jobs}},{:interview => {include: :consumed_foods}}]}}, :areas_users, :users, :regions]).to_json
                    end
                
                    #Create a new Area
                    app.post '/areas' do
                        area = Area.new(params[:area])    
                        area.save!
                        return {id: area.id}.to_json
                    end
					
					app.get '/areas/update/:date' do
						# this works in psql SELECT * FROM areas WHERE updated_at>'2014-10-13 16:48:40.527721';
						@areas = Area.where("updated_at>'" + params[:date] + "'").all
						rabl :areas, format: :json
					end
					
                    #Retreive an area
                    app.get '/areas/:id' do
                        @area = Area.find(params[:id])
						rabl :area, format: :json
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
