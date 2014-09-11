describe 'Occupations' do
	include RspecMixin
	context '/occupations' do
		it "returns a stringified array of all occupations the user can see" do
			occupation = FactoryGirl.create(:occupation)
            job = FactoryGirl.create(:job, {occupation: occupation})
			get '/occupations'
			json = last_response.body
			occupations = JSON.parse(json)
			expect(occupations.count).to eq(1)
            expect(occupations.first['id']).to eq(occupation.id)
			expect(occupations.first['name']).to eq(occupation.name)
            expect(occupations.first['job'].count).to eq(1)
		end

		it "creates a new occupation" do
			expect {
				post '/occupations', {occupation: {id: 1}}
			}.to change(Occupation, :count).by(1)
		end

	end

	context '/occupations/:id' do
		it "should return a specific occupation" do
			occupation = FactoryGirl.create(:occupation)
			get "/occupations/#{occupation.to_param}"
			json = last_response.body
			occupation_hash = JSON.parse(json)
            expect(occupation_hash['name']).to eq(occupation.name)
		end

        it "should update an existing occupation" do
			occupation = FactoryGirl.create(:occupation)
            put "/occupations/#{occupation.to_param}",{occupation:{name: 'wood'}}
			occupation.reload
            expect(occupation.name).to eq("wood")
		end

		it "should delete a occupation" do
			occupation = FactoryGirl.create(:occupation)
			delete "/occupations/#{occupation.to_param}"
            expect(Occupation.exists?(occupation.to_param)).to be false
		end
	end
end
