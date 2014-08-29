describe 'Households' do
	include RspecMixin
	context '/households' do
		it "returns a stringified array of all households" do
			household = FactoryGirl.create(:household)
			get '/households'
			json = last_response.body
			households = JSON.parse(json)
			expect(households.count).to eq(1)
			expect(households.first['id']).to eq(household.id)
			expect(households.first['name']).to eq(household.name)
		end

		it "creates a new household" do
			area = FactoryGirl.create(:area)
			expect {
				post '/households', {household: {name: 'household 51', area_id: area.to_param}}
			}.to change(Household, :count).by(1)
		end
	end
	
    context '/households/:id' do
		it "updates a household" do
			household = FactoryGirl.create(:household, name: "Johnson")
            put "/households/#{household.to_param}", {household: {name: 'Miller'}}
			household.reload
			expect(household.name).to eq("Miller")
		end

    	it "destroys a household" do 
        	household = FactoryGirl.create(:household)
            delete "/households/#{household.to_param}"
        	household.destroy
        	expect(household.id).to_be_nil
    	end
    
    	it "returns an id to a specific household" do
            household = FactoryGirl.create(:household)
            get "/households/#{household.to_param}"
            json = last_response.body
			household = JSON.parse(json)
            expect(houshold.id).to eq(Household.last.id)
        end

		it "should return a stringified version of the specified household" do
			household = FactoryGirl.create(:household)
			get "/households/#{household.to_param}"
			json = last_response.body
			household_hash = JSON.parse(json)
			expect(household_hash['name']).to eq(household.name)
		end
    end
end
