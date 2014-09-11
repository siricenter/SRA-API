describe 'People' do
	include RspecMixin
	context '/people' do
		it "returns a stringified array of all  the use" do
			interview = FactoryGirl.create(:interview)
			get '/interviews'
			json = last_response.body
			interviews = JSON.parse(json)
			retrieved_interview = Interview.new(interviews.first)
			expect(retrieved_interview).to eq(interview)
		end

		it "creates a new interview" do
			expect {
				post '/interviews', {interview: {id: 1}}
			}.to change(Interview, :count).by(1)
		end

	end