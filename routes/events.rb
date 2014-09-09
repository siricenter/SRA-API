module Sinatra
    module API
        module Routing
            module Events
            
                def self.registered(app)

                    #Retreives all the events
                    app.get '/events' do 
                        current_user.events.to_json
                    end
                
                    #Create a new event
                    app.post '/events' do
                        user = current_user
                        event = Event.new(params[:event]) 
                        user.events << event
                        user.save!
                    end

                    #Retreive an event
                    app.get '/events/:id' do
                        event = Event.find(params[:id]).to_json
                        if event.user == current_user
                            event
                        end
                    end

                    #Updates an event
                    app.put '/events/:id' do
                        event = Event.find(params[:id])
                        event.update(params[:area])
                        if event.user == current_user
                        	event.save
                        end
                    end
                    
                    #Destroys an event
                    app.delete '/events/:id' do
                        event = Event.find(params[:id])
                        if event.user == current_user
                        	event.destroy
                        end
                    end
                    
                end
            
            end
        end
    end
end