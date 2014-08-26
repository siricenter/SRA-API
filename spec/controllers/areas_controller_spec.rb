describe 'Areas' do
	context '/areas' do
		include RspecMixin
		it "returns a stringified array of all areas the user can see" do
			area = FactoryGirl.create(:area)
			get '/areas'
			json = last_response.body
			areas = JSON.parse(json)
			expect(areas.count).to eq(1)
			expect(areas.first['id']).to eq(area.id)
			expect(areas.first['name']).to eq(area.name)
		end

		it "creates a new area" do
			expect {
				post '/areas', {area: {name: 'Area 51'}}
			}.to change(Area, :count).by(1)
		end
	end

	context '/areas/:id' do
		include RspecMixin
		it "should return a stringified version of the specified array" do
			area = FactoryGirl.create(:area)
			get "/areas/#{area.to_param}"
			json = last_response.body
			area_hash = JSON.parse(json)
			expect(area_hash['name']).to eq(area.name)
		end

		it "should update a previously created area" do
			area = FactoryGirl.create(:area)
			put "/areas/#{area.to_param}", {area: {name: 'updated'}}
			area.reload
			expect(area.name).to eq('updated')
		end
	end
end
