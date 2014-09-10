###
# t.integer "area_id"
# t.integer "region_id"


FactoryGirl.define do
	factory :areas_regions do
    	area
    	region_id
	end
end
