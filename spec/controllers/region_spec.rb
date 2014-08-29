#class Region < ActiveRecord::Base
#  validates :name, presence: true, uniqueness: true
#
#  has_and_belongs_to_many :areas
#end

describe Region do
	include RspecMixin
	context '/regions' do
		it "returns a list of all existing regions" do
			region = FactoryGirl.create(:region)
			get '/regions'
			json = last_response.body
			regions = JSON.parse(json)
			expect(regions.count).to eq(1)
			expect(regions.first['id']).to eq(region.id)
			expect(regions.first['name']).to eq(region.name)
		end
		it 'deletes all regions' do
			region = FactoryGirl.create(:region)
			delete '/regions'
			region.destroy
			expect(regions.count).to eq(0)
		end
	end
	context '/regions/:id' do
		it "returns an existing region" do
			region = FactoryGirl.create(:region)
			get "/regions/#{region.to_param}"
			json = last_response.body
			region_js = JSON.parse(json)
			expect(region_js.count).to eq(1)
			expect(region_js.first['id']).to eq(region.id)
			expect(region_js.first['name']).to eq(region.name)
		end
		it 'deletes a specific region' do
			region = FactoryGirl.create(:region)
			delete "/regions/#{region.to_param}"
			region.destroy
			expect(region.id).to_be_nil
		end
		it 'updates an existing area' do
			region = FactoryGirl.create(:region)
			put "/regions/#{region.to_param}", {region: {name: 'updated'}}
			region.reload
			expect(region.name).to eq('updated')
		end    
	end
	context '/regions/:id/households/' do
		it 'should return all the households in a region' do
			region = FactoryGirl.create(:region)
			household = FactoryGirl.create(:household)
			region.households << household
			get "/regions/#{region.to_param}/households" 
			json = last_response.body
			households = JSON.parse(json)
			expect(households.count).to eq(1)
			expect(households.first['id']).to eq(region.households[0])
			expect(households.first['name']).to eq(region.households[0])    
		end
		it 'should delete all the households for a region' do
			region = FactoryGirl.create(:region)
			household = FactoryGirl.create(:household)
			households = region.households << household
			delete "/regions/#{region.to_param}/households"
			households.destroy
			expect(households.count).to eq(0)
		end
	end
	context '/regions/households/:id' do
		it 'should return a household in a region' do
			region = FactoryGirl.create(:region)
			household = FactoryGirl.create(:household)
			region.households << household
			get "/regions/households/#{household.to_param}"
			json = last_response.body
			household_js = JSON.parse(json)
			expect(household_js.first['id']).to eq(household.id)
			expect(household_js.first['name']).to eq(household.name)
		end
		it 'should delete a household in region' do
			region = FactoryGirl.create(:region)
			household = FactoryGirl.create(:household)
			household =  region.households << household
			delete "/regions/households/#{household.to_param}"
			household.destroy
			expect(household).to eq(0)
		end
	end
end
