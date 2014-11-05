describe 'Users' do
	include RspecMixin
	context '/users' do
		it "returns a stringified array of all users the administrator can see" do
			user = FactoryGirl.create(:user)
			area = FactoryGirl.create(:area)
			region = FactoryGirl.create(:region)
			role = FactoryGirl.create(:role)
            permission = FactoryGirl.create(:permission)
            
            
			events = FactoryGirl.create(:event, {user: user})
			household = FactoryGirl.create(:household, {area: area})
            
            
            areas_user = FactoryGirl.create(:areas_user, {area: area, user: user})
            areas_region = FactoryGirl.create(:areas_region, {area: area, region: region})
            roles_user = FactoryGirl.create(:roles_user, {role: role, user: user})
            permissions_role = FactoryGirl.create(:permissions_role,{permission: permission, role: role})
            
            
			person = FactoryGirl.create(:person,{household: household})
			interview = FactoryGirl.create(:interview, {household: household})
            
            
			consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
			job = FactoryGirl.create(:job, {person: person})
            
			get '/users'
			expect(last_response.status).to eq(200)
			json = last_response.body
			users = JSON.parse(json)
            expect(users).to_not be(nil)
			expect(users.count).to eq(1)
            expect(users.first['user']).to_not be(nil)
            expect(users.first['user']['id']).to eq(user.id)
            expect(users.first['user']['email']).to eq(user.email)
            expect(users.first['user']['password']).to eq(user.password)
			#expect(User.new(users.first['user'])).to eq(user)
            expect(users.first['user']['areas'].count).to eq(1)
            expect(users.first['user']['areas']).to_not be(nil)
            expect(users.first['user']['areas'].first['area']['id']).to eq(area.id)
            expect(users.first['user']['areas'].first['area']['name']).to eq(area.name)
            expect(users.first['user']['areas'].first['area']['regions'].first['region']['id']).to eq(region.id)
            expect(users.first['user']['areas'].first['area']['regions'].first['region']['name']).to eq(region.name)
            expect(users.first['user']['areas'].first['area']['households'].first['household']['id']).to eq(household.id)
            expect(users.first['user']['areas'].first['area']['households'].first['household']['name']).to eq(household.name)
			expect(users.first['user']['areas'].first['area']['households'].first['household']['interview']['id']).to eq(interview.id)
			expect(users.first['user']['areas'].first['area']['households'].first['household']['interview']['water_source']).to eq(interview.water_source)
			expect(users.first['user']['areas'].first['area']['households'].first['household']['interview']['consumed_foods'].first['consumed_food']['id']).to eq(consumed_food.id)
			expect(users.first['user']['areas'].first['area']['households'].first['household']['interview']['consumed_foods'].first['consumed_food']['n_id']).to eq(consumed_food.n_id)
            expect(users.first['user']['areas'].first['area']['households'].first['household']['people'].first['person']['id']).to eq(person.id)
            expect(users.first['user']['areas'].first['area']['households'].first['household']['people'].first['person']['given_name']).to eq(person.given_name)
			expect(users.first['user']['areas'].first['area']['households'].first['household']['people'].first['person']['jobs'].first['job']['id']).to eq(job.id)	
			expect(users.first['user']['areas'].first['area']['households'].first['household']['people'].first['person']['jobs'].first['job']['title']).to eq(job.title)			
		end

		it "creates a new User" do
			expect{post '/users', {user: {email: Faker::Internet.email,password: Faker::Internet.password}}}.to change(User, :count).by(1)
		end
	end

	context '/users/:id' do
		it "returns a stringified version of the specified user" do
			user = FactoryGirl.create(:user)
			get "/users/#{user.to_param}"
			expect(last_response.status).to eq(200)

			user_hash = last_response.body
			user1 = User.new(JSON.parse(user_hash))
			expect(user1).to eq(user)
		end

		it "updates the specified user" do
			user = FactoryGirl.create(:user)
			new_email = 'newemail@email.com'
			put "/users/#{user.to_param}", {user: {email: new_email}}
			user.reload
			expect(user.email).to eq(new_email)
		end

		it "destroys the specified user" do
			user = FactoryGirl.create(:user)
			expect {
				delete "/users/#{user.to_param}"
			}.to change(User, :count).by(-1)
		end
	end
end
