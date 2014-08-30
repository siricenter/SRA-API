describe 'Regions' do
	include RspecMixin
	context '/regions' do
		it 'returns a stringified list of all regions'
		it 'creates a new region'
	end

	context '/regions/:id' do
		it 'retrieves a specific region'
		it 'updates a specific region'
		it 'destroys a specific region'
	end
end
