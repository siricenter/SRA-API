# == Schema Information
#
# Table name: amenities
#
#  id          :integer          not null, primary key
#  image_id    :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :amenity do
    image_id "MyString"
    title "MyString"
    description "MyText"
  end
end
