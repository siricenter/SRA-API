describe 'Interviews' do
	include RspecMixin
	context '/interviews' do
		it "returns a stringified array of all interviews the user can see" do
			interview = FactoryGirl.create(:interview)
            consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
			
            get '/interviews'
			json = last_response.body
			interviews = JSON.parse(json)
			expect(interviews.count).to eq(1)
            expect(interviews.first['id']).to eq(interview.id)
            expect(interviews.first['consumed_food']).to eq(1)
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
            interview_hash = JSON.parse(json)
            expect(interview_hash['roof']).to eq(interview.roof)
		end

        it "should update an existing interview" do
			interview = FactoryGirl.create(:interview)
			put "/interviews/#{interview.to_param}",{interview:{roof: 'wood'}}
			interview.reload
			expect(interview.roof).to eq("wood")
		end

		it "should delete a interview" do
			interview = FactoryGirl.create(:interview)
			delete "/interviews/#{interview.to_param}"
            expect(Interview.exists?(interview.to_param)).to be false
		end
	end
end
