describe 'Areas' do
	include RspecMixin
	context '/areas' do
		it "returns a stringified array of all areas the user can see" do
			area = FactoryGirl.create(:area)
            user = FactoryGirl.create(:user)
            region = FactoryGirl.create(:region)
            occupation = FactoryGirl.create(:occupation)
            
            
            household = FactoryGirl.create(:household, {area: area})
            
            
            areas_user = FactoryGirl.create(:areas_user, {area: area, user: user})
            areas_region = FactoryGirl.create(:areas_region, {area: area, region: region})
            
            
            person = FactoryGirl.create(:person, {household: household})
            interview = FactoryGirl.create(:interview, {household: household})
            
            
            jobs = FactoryGirl.create(:job, {person: person, occupation: occupation})
            consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
            
            
			get '/areas'
			json = last_response.body
			areas = JSON.parse(json)
            expect(areas.count).to eq(1)
			expect(areas.first['area']['id']).to eq(area.id)
			expect(areas.first['area']['name']).to eq(area.name)
			expect(areas.first['area']['users'].count).to eq(1)
            expect(areas.first['area']['users'].first['user']['id']).to eq(user.id)
            expect(areas.first['area']['users'].first['user']['email']).to eq(user.email)
            expect(areas.first['area']['regions']).to_not be(nil)
            expect(areas.first['area']['regions'].first['region']['name']).to eq(region.name)
            expect(areas.first['area']['households'].first['household']['name']).to eq(household.name)
			expect(areas.first['area']['households'].first['household']['interview']['consumed_foods'].first['consumed_food']['id']).to eq(consumed_food.id)
            
		end
		
		it "should return a string of areas within a specified time frame" do
			date = "2014-10-13_16:48:40.527721"
			get "/areas/update/#{date}"
			json = last_response.body
			areas = JSON.parse(json)
			expect(areas).to_not be_nil
		end

		it "creates a new area" do
			expect {post '/areas', {area: {name: 'Area 51'}}}.to change(Area, :count).by(1)
		end
	end

	context '/areas/:id' do
		it "should return a stringified version of the specified array" do
			area = FactoryGirl.create(:area)
            
            
			get "/areas/#{area.to_param}"
			json = last_response.body
			area_hash = JSON.parse(json)
			expect(area_hash['area']['name']).to eq(area.name)
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
	context '/areas/update/:date' do
		it "should give back a list of areas within a specific time frame" do
			area = FactoryGirl.create(:area)
			date = '2014-10-13_16:48:40.527721'
			get "/areas/update/#{date}"
			json = last_response.body
			area_hash = JSON.parse(json)
			expect(area_hash).not_to be_empty
		end
	end
	
end
