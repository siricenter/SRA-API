set :enviroment, :test

def app
	Sinatra::Application
end

# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

describe Household do
	before :each do
		@household = FactoryGirl.build(:household)
		DatabaseCleaner.start
	end

	after :each do
		DatabaseCleaner.clean
	end

	it "has a valid factory" do
		@household.should be_valid
	end

	it "isn't valid without a name" do
		@household.name = nil
		@household.should_not be_valid
	end
	
	it "isn't valid without a user" do
		@household.user = nil
		@household.should_not be_valid
	end
end