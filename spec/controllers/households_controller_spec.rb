describe 'Households' do
	include RspecMixin
	context '/households' do
		it "returns a stringified array of all households" do
			household = FactoryGirl.create(:household)
			interview = FactoryGirl.create(:interview, {household: household})
			consumed_foods = FactoryGirl.create(:consumed_food, {interview: interview})
			person = FactoryGirl.create(:person, {household: household})
			jobs = FactoryGirl.create(:job, {person: person})
			
			get '/households'
			json = last_response.body
			households = JSON.parse(json)
			expect(households.first['household']['id']).to eq(household.id)
			expect(households.first['household']['name']).to eq(household.name)
            expect(households.first['household']['people'].first['person']['given_name']).to eq(person.given_name)
		end

		it "creates a new household" do
			area = FactoryGirl.create(:area)
			expect {post '/households', {household: {name: 'household 51', area_id: area.to_param}}}.to change(Household, :count).by(1)
		end
		it 'trys to create a household that already exists' do
			area = FactoryGirl.create(:area)
			household = FactoryGirl.create(:household, {area: area})
			person = FactoryGirl.create(:person, {household: household})
			expect{
				post '/houeholds', {household: household}
				}.to change(Household, :count).by(0)
		end
	end

	context '/households/:id' do
		it "should return a stringified version of the specified household" do
			household = FactoryGirl.create(:household)
			get "/households/#{household.to_param}"
			json = last_response.body
			household_hash = JSON.parse(json)
			expect(household_hash['household']['name']).to eq(household.name)
		end

		it "updates a household" do
			household = FactoryGirl.create(:household, name: "Johnson")
			put "/households/#{household.to_param}", {household: {name: 'Miller'}}
			household.reload
			expect(household.name).to eq("Miller")
		end

		it "should destroy a previously created household" do
			household = FactoryGirl.create(:household)
			expect {
				delete "/households/#{household.to_param}"
			}.to change(Household, :count).by(-1)
		end
	end
end
