describe 'Interviews' do
	include RspecMixin
    context '/interviews' do
        it "returns a stringified array of all interviews the user can see" do
            household = FactoryGirl.create(:interview)
            get '/interviews'
			json = last_response.body
            interviews = JSON.parse(json)
            expect(interviews.count).to eq(1)
            expect(interviews.first['id']).to eq(household.id)
            expect(interviews.first['name']).to eq(household.name)
		end

        it "creates a new interview" do
			expect {
                post '/interviews', {interview: {id: 1}}
                }.to change(Interview, :count).by(1)
		end
	end
end
