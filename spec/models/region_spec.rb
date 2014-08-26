describe Region do
	subject {FactoryGirl.build(:region)}

	it "has a valid factory" do
		expect(subject).to be_valid
	end

	it "is invalid without a name" do
		subject.name = nil
		expect(subject).to_not be_valid
	end

	it "is invalid with a duplicate name" do
		subject.save!
		second = FactoryGirl.build(:region)
		second.name = subject.name
		expect(second).to_not be_valid
	end
end
