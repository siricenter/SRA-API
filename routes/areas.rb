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
						area = Area.find_by(name: params[:name])
						if area.blank?
							{id: Area.create!(params[:area]).to_param}.to_json
					    else
							if area.people == params[:households]
								if params[:override] == null
									return "{error:[message:'resource already exists']}"
								elsif params[:override] == true
									# override
									{id: Household.create!(params[:household]).to_param}.to_json
								end
							else
							    {id: Household.create!(params[:household]).to_param}.to_json
							end
						end
                    end
                        area.save!
                        return {id: area.id}.to_json
                    end
					
					app.get '/areas/update/:date' do
						# this works in psql SELECT * FROM areas WHERE updated_at>'2014-10-13 16:48:40.527721';
						date = params[:date].tr("_", " ")
						@areas = Area.where("updated_at>'" + date + "'")
						rabl :areas, format: :json
					end
					
                    #Retreive an area
                    app.get '/areas/:id' do
                        @area = Area.find(params[:id])
						rabl :area, format: :json
                    end
					
					app.get '/areas/update/:date' do
						date = params[:date].tr("_", " ")
						@areas = Area.where('updated_at BETWEEN :date AND :now', {date: date, now: Time.now })
						rabl :areas_update, format: :json
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

