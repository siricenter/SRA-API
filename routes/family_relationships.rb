module Sinatra
    module API
        module Routing
            module FamilyRelationships
                def self.registered(app)
					#creates a new family_relationship
					app.post "/family_relationships" do
						relationship = FamilyRelationship.new(params[:family_relationship])
						relationship.save
						if relationship.save
							return 200
						else
							return 403
						end
					end
					#deletes a family_relationship
					app.delete "/family_relationship/:id" do
						relationship = FamilyRelationship.find(params[:id])
						relationship.delete
						if relationship.delete
							return 200
						else
							return 400
						end
					end
					#returns all the existing family_relationships
					app.get "/family_relationships" do
						FamilyRelationship.all.to_json
					end
					#returns a specfic family_relationship
					app.get "/family_relationships/:id" do
						FamilyRelationship.find(params[:id]).to_json
					end
					#updating a specific family_relationship
					app.put "/family_relationships/:id" do
						relationship = FamilyRelationship.find(params[:id])
						relationship = params[:family_relationship]
						relationship.save
						if relationship.save
							return 200
						else
							return 403
						end
					end
					app.get '/family_relationship/update/:date' do
						date = params[:date].tr("_", " ")
						@family_relationship = FamilyRelationship.where('updated_at BETWEEN :date AND :now', {date: date, now: Time.now })
						rabl :family_relationship, format: :json
					end  
                end
            end
        end
    end
end