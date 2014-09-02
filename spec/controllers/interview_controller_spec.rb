describe 'Interviews' do
	include RspecMixin
	context '/interviews' do
		it "returns a stringified array of all interviews the user can see" do
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

	context '/interviews/:id' do
		it "should return a specific interview" do
			interview = FactoryGirl.create(:interview)
			get "/interviews/#{interview.to_param}",{interviews:{id: 1}}
			json = last_response.body
			retrieved_interview = Interview.new(JSON.parse(json))
			expect(retrieved_interview).to eq(interview)
		end

        it "should update an existing interview" do
			interview = FactoryGirl.create(:interview)
			put "/interviews/#{interview.to_param}",{interview:{roof: 'wood'}}
			interview.reload
			expect(interview.roof).to eq("wood")
		end

		it "should delete a interview" do
			interview = FactoryGirl.create(:interview)

			expect {
				delete "/interviews/#{interview.to_param}", {interview: {id: 1}}
			}.to change(Interview, :count).by(-1)
		end
	end
end
