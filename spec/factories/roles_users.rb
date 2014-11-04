###
# t.integer "role_id"
# t.integer "user_id"


FactoryGirl.define do
	factory :roles_user do
		role
		user
	end
end
