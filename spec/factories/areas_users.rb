###
# t.integer "area_id"
# t.integer "user_id"
# t.string  "relationship"


FactoryGirl.define do
	factory :areas_user do
    	area
    	user
        relationship "Field Worker"
	end
end
