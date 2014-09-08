module Sinatra
    module API
        module Routing
            module Roles
            
                def self.registered(app)
                
                    #Retreives all roles
                    app.get '/roles' do
                        Role.all.to_json
                    end

                    #Create a role
                    app.post '/roles' do
                        {id: Role.create(params[:role]).id}.to_json
                    end

                    #Retreive a role
                    app.get '/roles/:id' do
                        Role.find(params[:id]).to_json
                    end

                    #Update a role
                    app.put '/roles/:id' do
                        Role.find(params[:id]).update(params[:role]).to_json
                    end

                    #Delete a role
                    app.delete '/roles/:id' do
                        Role.find(params[:id]).destroy
                    end
                    
                end
            
            end
        end
    end
end