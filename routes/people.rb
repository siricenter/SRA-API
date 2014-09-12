module Sinatra
    module API
        module Routing
            module People
            
                def self.registered(app)
                    
                    #Retreives all the people 
                    app.get '/people' do
						@people = Person.all #.as_json(include: :jobs).to_json
						rabl :people, format: :json
                    end
                    
                    #Create a person
					app.post '/households/:household_id/people' do
                        household = Household.find(params[:household_id])
                        person = Person.new(params[:person].except(:family_relationship))
                        household.people << person
                        person.save!
                    end

                    #Retreives a person
                    app.get '/people/:id' do
						@person = Person.find(params[:id])
						rabl :person, format: :json
                    end
                    
                    #Updates a person
                    app.put '/people/:id' do
                        person = Person.find(params[:id])
                        person.attributes = params[:person].except("family_relationship")
                        relationship = FamilyRelationship.find_by_name(params[:person][:family_relationship])
                        person.family_relationship = relationship
                        person.save!
                    end
                    
                    #Delete a person
                    app.delete '/people/:id' do
                        person = Person.find(params[:id])
                        person.destroy
                    end
                    
                end
            
            end
        end
    end
end