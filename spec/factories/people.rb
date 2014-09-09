FactoryGirl.define do
	factory :person do
		given_name { Faker::Name.first_name  }
		family_name { Faker::Name.last_name  }
		birthday Time.now
		education_level "some college"
		gender "male"
		in_school true
        household
	end
end
