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

		it "should return a stringified version of the specified household" do
			household = FactoryGirl.create(:household)
			get "/households/#{household.to_param}"
			json = last_response.body
			household_hash = JSON.parse(json)
			expect(household_hash['name']).to eq(household.name)
		end
    end

    context '/households/interview/:id' do
        it "should return the interview associated with the household" do
            household = FactoryGirl.create(:household)
            household.interviews << Interview.new
            get "/households/interview/#{interview.to_param}"
            json = last_response.body
            interview = JSON.parse(json)
            expect(interview.count).to eq(1)
            expect(interview.first['id']).to eq(household.interview.id)
        end
		
        it "should delete an interview associated with a household" do
            household = FactoryGirl.create(:household)
            household.interviews << Interview.new
            delete "/households/#{interview.to_param}"
            household.destroy
            expect(Interview.exists?(interview.to_param)).to be false
        end

        it "should update an interview associated with a household" do
            household = FactoryGirl.create(:household)
            household.interviews << Interview.new
            put "/households/#{interview.to_params}",{interview:{roof: "tin"}}
            household.interviews.reload
            expect(household.interviews.roof).to eq("tin")
        end
	end
end
