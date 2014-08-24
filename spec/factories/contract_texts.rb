# == Schema Information
#
# Table name: contract_texts
#
#  id                      :integer          not null, primary key
#  contract                :text
#  living_standards        :text
#  parking_acknowledgement :text
#  eligibility             :text
#  created_at              :datetime
#  updated_at              :datetime
#  addendum                :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contract_text do
    contract "MyText"
    living_standards "MyText"
    parking_acknowledgement "MyText"
    eligibility "MyText"
  end
end
