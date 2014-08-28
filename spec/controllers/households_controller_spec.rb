describe 'Households' do
	include RspecMixin
	context '/households' do
		it "returns a stringified array of all households the user can see" do
			household = FactoryGirl.create(:household)
			get '/households'
			json = last_response.body
			households = JSON.parse(json)
			expect(households.count).to eq(1)
			expect(households.first['id']).to eq(household.id)
			expect(households.first['name']).to eq(household.name)
		end
        
		it "should create a household" do
            household = FactoryGirl.create(:household)
            expect {
                post '/households', {household: {name: 'Johnson'}}
			}.to change(Area, :count).by(1)
		end
        
        it "should update all households" do
			household = FactoryGirl.create(:household, name: "Johnson")
			household2 = FactoryGirl.create(:household, name: "Scott")
            households = Household.all
            households.each do |household|
                put "/households/#{household.to_param}", {household: {name: 'Miller'}}
				household.reload
				expect(household['name']).to eq("Miller")
            end
        end
        
        it "should delete all households" do
			household = FactoryGirl.create(:household, name: "Johnson")
			household2 = FactoryGirl.create(:household, name: "Scott")
            households = Household.all
            households.each do |household|
                household.delete
                expect(household['id'].to eq(nil))
            end
        end
	end
    context '/households/:id' do
		it "updates a household" do
			household = FactoryGirl.create(:household, name: "Johnson")
            put "/households/#{household.to_param}", {household: {name: 'Miller'}}
			household.reload
			expect(household['name']).to eq("Miller")
		end
    
    	it "delete a household" do 
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
    end
end
