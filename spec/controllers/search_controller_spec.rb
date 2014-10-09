describe 'Consumed Foods' do
	include RspecMixin
	context '/search' do
		it "returns a list of food" do
			query = 'corn'
			post '/search', {query: query}
			json = last_response.body
			results = JSON.parse(json)
			expect(results['hits'].first['_id']).to_not be_nil
		end
	end
end