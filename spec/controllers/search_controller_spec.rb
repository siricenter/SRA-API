describe 'Consumed Foods' do
	include RspecMixin
	context '/consumed_foods' do
		it "returns a list of food" do
			query = 'corn'
			post '/search', {query: query}
			json = last_response.body
			results = JSON.parse(json)
			expect(results.n_id).should_not eq(0)
			
		end
	end
end