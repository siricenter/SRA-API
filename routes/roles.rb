module Sinatra
    module API
        module Routing
            module Roles
            
                def self.registered(app)
                
                    #Retreives all roles
                    app.get '/roles' do
						@roles = Role.all
						rabl :roles, format: :json
                    end

                    #Create a role
                    app.post '/roles' do
                        {id: Role.create(params[:role]).id}.to_json
                    end

                    #Retreive a role
                    app.get '/roles/:id' do
						@role = Role.find(params[:id])
						rabl :role, format: :json
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