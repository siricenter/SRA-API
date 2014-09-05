# == Schema Information
#
# Table name: api_keys
#


FactoryGirl.define do
  factory :api_key do
    key UUID.new.generate
    app_name 'MyAppName'
    type 'webApp'
    owner 'Jimmy'
  end
end