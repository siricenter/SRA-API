describe 'Regions' do
	include RspecMixin
	context '/regions' do
		it 'returns a stringified list of all regions' do
			region = FactoryGirl.create(:region)
            user = FactoryGirl.create(:user)
            area = FactoryGirl.create(:area)
            areas_regions = FactoryGirl.create(:areas_region, {area: area, region: region})
            household = FactoryGirl.create(:household, {area: area})
            person = FactoryGirl.create(:person, {household: household})
            jobs = FactoryGirl.create(:job, {person: person})
            interview = FactoryGirl.create(:interview, {household: household})
            consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
			
            get '/regions'
			expect(last_response.status).to eq(200)

			json = last_response.body
			regions = JSON.parse(json)
			expect(regions.count).to eq(1)

			expect(regions.first['region']['name']).to eq(region.name)
			expect(regions.first['region']['areas'].first['households'].first['name'] ).to eq(household.name)
			expect(regions.first['region']['areas'].first['households'].first['people'].first['given_name']).to eq(person.given_name)
			expect(regions.first['region']['areas'].first['households'].first['interview']['roof']).to eq(interview.roof)
			expect(regions.first['region']['areas'].first['households'].first['people'].first['jobs'].first['title']).to eq(jobs.title)
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
			get "/regions/#{region.to_param}"
			expect(last_response.status).to eq(200)
			
			json = last_response.body
			region1_hash = JSON.parse(json)
			region1 = Region.new(region1_hash)
			expect(region1).to eq(region)
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
