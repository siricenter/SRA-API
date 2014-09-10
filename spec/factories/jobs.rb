###
# t.string   "title"
# t.boolean  "seasonal"
# t.string   "description"
# t.integer  "person_id"
# t.integer  "occupation_id"


FactoryGirl.define do
	factory :job do
		title "Potato Picker"
    	seasonal true
    	description "picks potatoes out of the ground"
    	person
    	occupation
	end
end
