module Sinatra
    module API
        module Routing
            module AreasRegions
            
                def self.registered(app)
                    
                    #Creates a new AreasRegions
                    app.post '/areas/:area_id/regions/:region_id' do
						area = Area.find(params[:area_id])
                        region = Region.find(params[:region_id])
                        area_region = AreasRegion.new
        				area_region.area = area
                        area_region.region = region
						area_region.save
						if area_region.save 
							return 200
						else
							return 403
						end
					end
					
                    #Deletes a AreasRegions
                    app.delete '/areas/:area_id/regions/:region_id' do
						area = Area.find(params[:area_id])
                        region = Region.find(params[:region_id])
                        area.regions.delete(region) if area.regions.include?(region)
							if area.delete
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
                