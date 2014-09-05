# == Schema Information
#
# Table name: areas
#
#  id         :integer
#  key        :string
#  app_name   :string
#  type       :string
#  owner      :sting
#  created_at :datetime
#  updated_at :datetime
#

set :enviroment, :test

describe ApiKey do
	subject {FactoryGirl.build(:api_key)}

	it "has a valid factory" do
		expect(subject).to be_valid
	end

end
