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


	it "is invalid without key" do
		subject.key = nil
		expect(subject).to_not be_valid
	end

	it "is invalid without app_name" do
		subject.app_name = nil
		expect(subject).to_not be_valid
	end

	it "is invalid without type" do
		subject.type = nil
		expect(subject).to_not be_valid
	end

	it "is invalid without owner" do
		subject.owner = nil
		expect(subject).to_not be_valid
	end

end
