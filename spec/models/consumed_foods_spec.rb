# == Schema Information
#
# Table name: consumed_foods
#
#  id           :integer          not null, primary key
#  interview_id :integer
#  n_id         :string(255)
#  servings     :integer
#  frequency    :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_consumed_foods_on_interview_id  (interview_id)
#
describe CosumedFood do
    subject {FactoryGirl.create(:consumed_food)}
    context '/areas/users/household/interview/consumed_food' do
		it "should have a valid factory" do
			expect(subject).to be_valid
		end
	end
end