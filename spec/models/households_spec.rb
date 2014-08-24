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
	subject {FactoryGirl.build(:household)}

	it "has a valid factory" do
		expect(subject).to be_valid
	end

	it "isn't valid without a name" do
		subject.name = nil
		expect(subject).to_not be_valid
	end

	it "isn't valid without a user" do
		subject.user = nil
		expect(subject).to_not be_valid
	end
end
