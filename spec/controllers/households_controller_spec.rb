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

		it "creates a new household" do
			expect {
				post '/households', {household: {name: 'household 51'}}
			}.to change(household, :count).by(1)
		end
	end
end
