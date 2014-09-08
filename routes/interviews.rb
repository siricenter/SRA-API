module Sinatra
    module API
        module Routing
            module Interviews
            
                def self.registered(app)
                    
                    #Retreives all interviews
                    app.get '/interviews' do
                        Interview.all.to_json
                    end

                    #Create an interview
                    app.post '/interviews' do
                        {id: Interview.create(params[:interview]).id}.to_json
                    end

                    #Retreive an interview
                    app.get '/interviews/:id' do
                        Interview.find(params[:id]).to_json
                    end

                    #Update an interview
                    app.put '/interviews/:id' do
                        Interview.find(params[:id]).update(params[:interview])
                    end

                    #Delete an interview
                    app.delete '/interviews/:id' do
                        Interview.find(params[:id]).destroy
                    end
                    
                end
            
            end
        end
    end
end