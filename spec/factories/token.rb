require 'uuid'
UUID.state_file = false
UUID.generator.next_sequence

FactoryGirl.define do
    factory :token do
        uuid = UUID.new
        token_string uuid.generate
        user_id 1
	end
end
