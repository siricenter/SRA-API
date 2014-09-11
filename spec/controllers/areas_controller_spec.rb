describe 'Areas' do
	include RspecMixin
	context '/areas' do
		it "returns a stringified array of all areas the user can see" do
			area = FactoryGirl.create(:area)
            user = FactoryGirl.create(:user)
            region = FactoryGirl.create(:region)
            areas_users = FactoryGirl.create(:areas_users, {area: area, user: user})
            areas_regions = FactoryGirl.create(:areas_regions, {area: area, region: region})
            household = FactoryGirl.create(:household, {area: area})
            person = FactoryGirl.create(:person, {household: household})
            jobs = FactoryGirl.create(:job, {person: person})
            interview = FactoryGirl.create(:interview, {household: household})
            consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
            
			get '/areas'
			json = last_response.body
			areas = JSON.parse(json)
            expect(areas.count).to eq(1)
			expect(areas.first['id']).to eq(area.id)
			expect(areas.first['name']).to eq(area.name)
            expect(areas.first['user'].count).to eq(1)
            expect(areas.first['region'].count).to eq(1)
            expect(areas.first['areas_users'].count).to eq(1)
            expect(areas.first['areas_regions'].count).to eq(1)
            expect(areas.first['households'].count).to eq(1)
            expect(areas.first['households'].first['interviews'].count).to eq(1)
            expect(areas.first['households'].first['interviews'].first['consumed_foods'].count).to eq(1)
            expect(areas.first['households'].first['people'].count).to eq(1)
            expect(areas.first['households'].first['people'].first['jobs'].count).to eq(1)
            
		end

		it "creates a new area" do
			expect {
				post '/areas', {area: {name: 'Area 51'}}
			}.to change(Area, :count).by(1)
		end
	end

	context '/areas/:id' do
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

		it "should destroy a previously created area" do
			area = FactoryGirl.create(:area)
			delete "/areas/#{area.to_param}"
			expect(Area.exists?(area.to_param)).to be false
		end
    end
end