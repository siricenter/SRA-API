###
# permissions_roles
# t.integer "permission_id"
# t.integer "role_id"


FactoryGirl.define do
	factory :permissions_role do
    	permission
    	role
	end
end