module Sinatra
    module API
        module Routing
            module Users
                def self.registered(app)
                    #Retreives all the users 
                    app.get '/users' do
                        @users = User.all
                        rabl :users, format: :json
                    end
                    
                    #Create a user
                    app.post '/users' do
                        User.create!(params[:user])
                    end

                    #Retreives a user
                    app.get '/users/:id' do
                        User.find(params[:id]).to_json
                    end
                    
                    #Updates a user
                    app.put '/users/:id' do
                        User.find(params[:id]).update(params[:user])
                    end
                    
                    #Delete a user
                    app.delete '/users/:id' do
                        User.find(params[:id]).destroy
                    end
					app.get '/users/update/:date' do
						date = params[:date].tr("_", " ")
						@users = User.where('updated_at BETWEEN :date AND :now', {date: date, now: Time.now })
						rabl :users_update, format: :json
					end  
                end
            end
        end
    end
end