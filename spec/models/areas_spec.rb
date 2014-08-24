# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

set :enviroment, :test

def app
	Sinatra::Application
end

describe Area do
	subject {FactoryGirl.build(:area)}

	it "has a valid factory" do
		expect(subject).to be_valid
	end

	it "is invalid without a name" do
		subject.name = nil
		expect(subject).to_not be_valid
	end
end
