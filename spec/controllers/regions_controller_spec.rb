describe 'Regions' do
	include RspecMixin
	context '/regions' do
        it 'returns a stringified list of all regions' do
			region = FactoryGirl.create(:region)
            user = FactoryGirl.create(:user)
            area = FactoryGirl.create(:area)
            
            household = FactoryGirl.create(:household, {area: area})
            
            FactoryGirl.create(:areas_region, {area: area, region: region})
            FactoryGirl.create(:areas_user, {area: area, user: user})
            
            person = FactoryGirl.create(:person, {household: household})
            interview = FactoryGirl.create(:interview, {household: household})
            
            jobs = FactoryGirl.create(:job, {person: person})
            consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
			
            get '/regions'
			expect(last_response.status).to eq(200)

			json = last_response.body
			regions = JSON.parse(json)
			expect(regions.count).to eq(1)
			expect(regions.first['region']['name']).to eq(region.name)
            expect(regions.first['region']['areas'].first['area']['users'].first['user']['email'] ).to eq(user.email)
            expect(regions.first['region']['areas'].first['area']['name']).to eq(area.name)
			expect(regions.first['region']['areas'].first['area']['households'].first['household']['name'] ).to eq(household.name)
			expect(regions.first['region']['areas'].first['area']['households'].first['household']['people'].first['person']['given_name']).to eq(person.given_name)
			expect(regions.first['region']['areas'].first['area']['households'].first['household']['interview']['roof']).to eq(interview.roof)
			expect(regions.first['region']['areas'].first['area']['households'].first['household']['people'].first['person']['jobs'].first['job']['title']).to eq(jobs.title)
			expect(regions.first['region']['areas'].first['area']['households'].first['household']['interview']['consumed_foods'].first['consumed_food']['n_id']).to eq(consumed_food.n_id)
        end

		it 'creates a new region' do
			expect {
				post '/regions', {region: {name: 'Ukraine'}}
			}.to change(Region, :count).by(1)
		end
	end

	context '/regions/:id' do
		it 'retrieves a specific region' do
			region = FactoryGirl.create(:region)
			user = FactoryGirl.create(:user)
            area = FactoryGirl.create(:area)
            occupation = FactoryGirl.create(:occupation)
            
            household = FactoryGirl.create(:household, {area: area})
            
            FactoryGirl.create(:areas_region, {area: area, region: region})
            FactoryGirl.create(:areas_user, {area: area, user: user})
            
            person = FactoryGirl.create(:person, {household: household})
            interview = FactoryGirl.create(:interview, {household: household})
            
            jobs = FactoryGirl.create(:job, {person: person, occupation: occupation})
            consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
			
            get "/regions/#{region.to_param}"
			expect(last_response.status).to eq(200)
			
			json = last_response.body
			jRegion = JSON.parse(json)
            expect(jRegion['region']['name']).to eq(region.name)
            
			expect(jRegion['region']['areas'].first['area']['name']).to eq(area.name)
            expect(jRegion['region']['areas'].first['area']['users']).to_not be(nil)
            expect(jRegion['region']['areas'].first['area']['users'].count).to eq(1)
            expect(jRegion['region']['areas'].first['area']['users'].first['user']['email']).to eq(user.email)
			expect(jRegion['region']['areas'].first['area']['households'].first['household']['name']).to eq(household.name)
		end

		it 'updates a specific region' do
			region = FactoryGirl.create(:region)
			put "/regions/#{region.to_param}", {region: {name: 'updated'}}
			region.reload
			expect(region.name).to eq('updated')
		end

		it 'destroys a specific region' do
			region = FactoryGirl.create(:region)
			expect {
				delete "/regions/#{region.to_param}"
			}.to change(Region, :count).by(-1)
		end
	end
end
