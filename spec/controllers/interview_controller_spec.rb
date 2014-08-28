describe 'Interviews' do
	include RspecMixin
	context '/interviews' do
		it "returns a stringified array of all interviews the user can see" do
			household = FactoryGirl.create(:interview)
			get '/interviews'
			json = last_response.body
			interviews = JSON.parse(json)
			expect(interviews.count).to eq(1)
			expect(interviews.first['id']).to eq(interview.id)
			expect(interviews.first['name']).to eq(interview.name)
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
			get "/interviews/#{interview.to_params}",{interviews:{id: 1}}
			json = last_response.body
			interview = JSON.parse(json)
			expect(interview.count).to eq(1)
			expect(interview.first['id']).to eq(interview.id)
			expect(interview.first['name']).to eq(interview.name)
		end

        it "should update an existing interview" do
			interview = FactoryGirl.create(:interview)
			put "/interviews/#{interview.to_params}",{interview:{roof: "tin"}}
			interview.reload
			expect(interview.roof).to eq("tin")
		end
		it "should delete a interview" do
			interview = FactoryGirl.create(:interview)

			expect {
				delete "/interviews/#{interview.to_params}", {interview: {id: 1}}
			}.to change(Interview, :count).by(-1)
		end
	end
end
