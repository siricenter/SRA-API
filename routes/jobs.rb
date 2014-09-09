module Sinatra
    module API
        module Routing
            module Jobs
            
                def self.registered(app)
                    
                    #Retreives all the jobs
                    app.get '/jobs' do 
                        person = Person.find(params[:person_id])
                        person.jobs.to_json
                    end
                
                    #Create a new job
                    app.post '/jobs' do
                        person = Person.find(params[:person_id])
                        job = person.jobs.build()
                        job.update_attributes(params[:job].except("occupation"))
                        job.occupation = Occupation.find_by_name(params[:job][:occupation])
                        job.save!
                    end

                    #Retreive a job
                    app.get '/jobs/:id' do
                        Job.find(params[:id]).to_json
                    end

                    #Updates a job
                    app.put '/jobs/:id' do
                        Job.find(params[:id]).update(params[:job])
                    end
                    
                    #Destroys a job
                    app.delete '/jobs/:id' do
                        Job.find(params[:id]).destroy
                    end
                    
                end
            
            end
        end
    end
end