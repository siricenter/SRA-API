describe 'People' do
	include RspecMixin
	context '/people' do
		it "returns a stringified array of all people" do
			person = FactoryGirl.create(:person)
			job = FactoryGirl.create(:job, {person: person})
			get '/people'
			json = last_response.body
            people = JSON.parse(json)
            expect(people.first['person']['given_name']).to eq(person.given_name)	
            expect(people.first['person']['jobs'].first['title']).to eq(job.title)
		end
#Birthday can't be blank, Education level can't be blank, Family name can't be blank, Gender can't be blank, Given name can't be blank
		it "creates a new person_js" do
			household = FactoryGirl.create(:household)
			expect {
				post "/households/#{household.to_param}/people", {person: {id: 4000, birthday: Time.now, education_level: 'Some college', family_name:'Pitt', gender:'Male', given_name:'Brad'}}
				}.to change(household.people, :count).by(1)
		end
		
		it "deletes a person" do
			person = FactoryGirl.create(:person)
			person.save
			delete "/people/#{person.to_param}"
			person.destroy
			expect(Person.count).to eq(0)
		end
		it 'updates a person' do
			person = FactoryGirl.create(:person)
			post "/people/#{person.to_param}", {:person => {:given_name => 'Willy', :family_name => 'Wonka', :education_level => 'None', :gender => 'female'}}
			person.reload
			expect(person[:given_name]).to eq('Willy')
			expect(person[:family_name]).to eq('Wonka')
			expect(person[:education_level]).to eq('None')
			expect(person[:gender]).to eq('female')
		end
	end
end