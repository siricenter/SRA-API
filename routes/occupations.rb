module Sinatra
    module API
        module Routing
            module Occupations
            
                def self.registered(app)
					#returns all the occupations currently existing in Database 
					app.get "/occupations" do
						occupations = Occupation.all.as_json(include: :jobs)
						occupations.to_json
						
					end
					#returns a specific occupation
					app.get "/occupations/:id" do
						occupation = Occupation.find(params[:id])
						occupation.to_json
					end
					#deletes a specfic area
					app.delete "/occupations/:id" do
						occupation = Occupation.find(params[:id])
						occupation.delete
						if occupation.delete
							return 200
						else
							return 403
						end
					end
					#creates an occupation
					app.post "/occupations" do
						occupation = Occupation.new(params[:occupation])
						occupation.save
						if occupation.save
							return 200
						else
							return 400
						end
					end
					#updates an occupation
					app.put "/occupations/:id" do
						occupation = Occupation.find(params[:id])
						occupation.update(params[:occupation])
						occupation.reload
						if occupation.reload
							return 200
						else
							return 403
						end
					end
                end
            end
        end
    end
end
