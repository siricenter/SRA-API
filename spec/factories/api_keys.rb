# == Schema Information
#
# Table name: api_keys
#


FactoryGirl.define do
  factory :api_key do
    key 'Aza928dhA'
    app_name 'MyAppName'
    type 'webApp'
    owner 'Jimmy'
  end
end