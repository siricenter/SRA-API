###
# t.integer "area_id"
# t.integer "region_id"


FactoryGirl.define do
	factory :areas_region do
    	area
    	region
	end
end
