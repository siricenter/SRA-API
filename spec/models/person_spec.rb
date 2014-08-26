describe Person do
	subject {FactoryGirl.build(:person)}

	it "has a valid factory" do
		expect(subject).to be_valid
	end

	it "is invalid without a birthday" do
		subject.birthday = nil
		expect(subject).to_not be_valid
	end

	it "is invalid without an education_level" do
		subject.education_level = nil
		expect(subject).to_not be_valid
	end

	it "is invalid without a family_name" do
		subject.family_name = nil
		expect(subject).to_not be_valid
	end

	it "is invalid without a gender" do
		subject.gender = nil
		expect(subject).to_not be_valid
	end

	it "is invalid without a given_name" do
		subject.given_name = nil
		expect(subject).to_not be_valid
	end
end
