# == Schema Information
#
# Table name: marketing_texts
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :marketing_text do
    text "You could walk a long way to campus, but why? Welcome Home!"
  end
end
