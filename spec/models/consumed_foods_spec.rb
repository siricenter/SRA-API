describe CosumedFood do
    subject {FactoryGirl.create(:consumed_food)}
    context '/areas/users/household/interview/consumed_food' do
		it "should have a valid factory" do
			expect(subject).to be_valid
		end
	end
end