###
# t.string   "title"
# t.datetime "start"
# t.integer  "user_id"

FactoryGirl.define do
	factory :event do
    	title "Party"
    	start Date.current
    	user
	end
end