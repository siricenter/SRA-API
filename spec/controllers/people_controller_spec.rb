describe 'People' do
	include RspecMixin
	context '/people' do
		it "returns a stringified array of all people" do
			person = FactoryGirl.create(:person)
			job = FactoryGirl.create(:job, {person: person})
			get '/people'
			json = last_response.body
			person_js = JSON.parse(json)
			expect(person_js).to eq(person)	
			expect(person_js.first['job']).to eq(job)
		end

		it "creates a new person_js" do
			expect {
				post '/people', {person: {id: 1}}
				}.to change(Person, :count).by(1)
		end
		
		it "deletes a person" do
			person = FactoryGirl.create(:person)
			person.save
			delete "/people/#{person.to_param}"
			person.destroy
			expect(person.count).to eq(0)
		end
		it 'updates a person' do
			person = FactoryGirl.create(:person)
			put "/people/#{person.to_param}"
			person = params[:person => {give_name: 'Willy', family_name: 'Wonka',education_level: 'None', gender: 'female'}]
			person.save
			expect(person[:given_name]).to eq('Willy')
			expect(person[:family_name]).to eq('Wonka')
			expect(person[:education_level]).to eq('None')
			expect(person[:gender]).to eq('female')
		end
	end
end