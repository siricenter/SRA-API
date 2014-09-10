###
# t.integer "area_id"
# t.integer "user_id"
# t.string  "relationship"


FactoryGirl.define do
	factory :areas_users do
    	area
    	user
    	relationship "Lives there"
	end
end
