module Sinatra
    module API
        module Routing
            module Interviews
            
                def self.registered(app)
                    
                    #Retreives all interviews
                    app.get '/interviews' do
						Interview.all.as_json(include: :consumed_foods).to_json
                    end

                    #Create an interview
                    app.post '/interviews' do
                        @household = Household.find(params[:household_id])
		                @interview = Interview.new(params[:interview])
		                @interview.household = @household
		                @path = [@household, @interview]
                        if params[:consumed_foods]
			                params[:consumed_foods].each do |key, food|
				                @interview.consumed_foods.build(food)
                            end
                        end
                        @interview.save!
                        return {id: @interview.id}.to_json
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