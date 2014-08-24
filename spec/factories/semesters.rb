# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  deposit    :integer
#  rent       :integer
#  duration   :integer
#  start_date :date
#  end_date   :date
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  	factory :semester do
      name {Faker::Name.first_name}
	  	deposit 50
		rent 1500
		duration 1
		start_date Date.tomorrow
		end_date Date.tomorrow + 1
  	end
end
