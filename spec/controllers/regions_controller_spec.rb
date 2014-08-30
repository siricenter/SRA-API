describe 'Regions' do
	include RspecMixin
	context '/regions' do
		it 'returns a stringified list of all regions' do
			region = FactoryGirl.create(:region)
			get '/regions'
			expect(last_response.status).to eq(200)

			json = last_response.body
			regions = JSON.parse(json)
			expect(regions.count).to eq(1)

			region1 = Region.new(regions.first)
			expect(region1).to eq(region)
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

		it 'updates a specific region'
		it 'destroys a specific region'
	end
end
