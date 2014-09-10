module Sinatra
    module API
        module Routing
            module Users
            
                def self.registered(app)
                
                    #Retreives all the users 
                    app.get '/users' do
                        User.all.to_json
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
                end
            end
        end
    end
end