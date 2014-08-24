describe 'Areas' do
	context '/areas' do
		area1 = FactoryGirl.create(:area)
		get '/areas'
		json = response.body
		area = Area.build(JSON.parse(json))
		expect(area).to_not eq(area1)
	end
end
