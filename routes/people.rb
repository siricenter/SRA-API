module Sinatra
    module API
        module Routing
            module People
            
                def self.registered(app)
                    
                    #Retreives all the people 
                    app.get '/people' do
                        Person.all.to_json
                    end
                    
                    #Create a person
                    app.post '/people' do
                        household = Household.find(params[:household_id])
                        relationship = FamilyRelationship.find_by_name(params[:person][:family_relationship])
                        person = Person.new(params[:person].except(:family_relationship))
                        person.family_relationship = relationship
                        household.people << person
                        person.save!
                    end

                    #Retreives a person
                    app.get '/people/:id' do
                        Person.find(params[:id]).to_json
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
                        household = person.household
                        person.destroy
                    end
                    
                end
            
            end
        end
    end
end