module Sinatra
    module API
        module Routing
            module AreasUsers
                def self.registered(app)
					#Creates a new relationship
					app.post '/areas/:area_id/users/:user_id' do
						area = Area.find(params[:area_id])
						user = User.find(params[:user_id])
        				relationship = params[:relationship]
						area_user = AreasUser.new
        				area_user.area = area
       					area_user.user = user
       					area_user.relationship = relationship
						area_user.save
						if area_user.save 
							return 200
						else
							return 403
						end
					end
					
						#Deletes a relationship
					app.delete '/areas/:area_id/users/:user_id' do
						area = Area.find(params[:area_id])
						user = User.find(params[:user_id])
						area.users.delete(user) if area.users.include?(user)
							if area.delete
								return 200
							else
								return 403
							end
					end
					
					app.get '/areas_users/update/:date' do
						date = params[:date].tr("_", " ")
						@areas_users = AreaUsers.where('updated_at BETWEEN :date AND :now', {date: date, now: Time.now })
						rabl :areas, format: :json
					end  
                end
            end
        end
    end
end 
                