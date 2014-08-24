# == Schema Information
#
# Table name: contracts
#
#  id                   :integer          not null, primary key
#  semester_id          :integer
#  first_name           :string(255)
#  last_name            :string(255)
#  email                :string(255)
#  home_address_1       :string(255)
#  home_address_2       :string(255)
#  home_city            :string(255)
#  home_state           :string(255)
#  home_zip             :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  parking_type         :string(255)
#  phone                :string(255)
#  apartment_type       :string(255)
#  building_id          :integer
#  eligibility_sig      :string(255)
#  living_standards_sig :string(255)
#  parking_ack          :string(255)
#  euro                 :string(255)
#  contract_agreement   :string(255)
#  preferences          :text
#  number               :text
#  contract_text_id     :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :contract do
		semesters {[FactoryGirl.build(:semester)]}
		building 
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		email 'student1@byui.edu'
		home_address_1 { Faker::Address.street_address }
		home_address_2 { Faker::Address.secondary_address }
		home_city { Faker::Address.city }
		home_state { Faker::Address.state }
		home_zip { Faker::Address.zip }
		apartment_type "6 Person"
		parking_type 'Private Uncovered'
		phone '555-555-5555'
		eligibility_sig "John Doe"
		living_standards_sig "John Doe"
		parking_ack "John Doe"
		contract_agreement "John Doe"
		euro ""
	end
end
