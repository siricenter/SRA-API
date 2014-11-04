describe 'Users' do
	include RspecMixin

	context '/users' do
		it "returns a stringified array of all users the administrator can see" do
			user = FactoryGirl.create(:user)
			area = FactoryGirl.create(:area)
            area_user = FactoryGirl.create(:areas_user, {area: area, user: user})
			region = FactoryGirl.create(:region)
            area_region = FactoryGirl.create(:areas_region, {area: area, region: region})
			household = FactoryGirl.create(:household, {area: area})
			interview = FactoryGirl.create(:interview, {household: household})
			consumed_food = FactoryGirl.create(:consumed_food, {interview: interview})
			person = FactoryGirl.create(:person,{household: household})
			job = FactoryGirl.create(:job, {person: person})
			events = FactoryGirl.create(:event, {user: user})
			role = FactoryGirl.create(:role)
            role_user = FactoryGirl.create(:roles_user, {role: role, user: user})
            permission = FactoryGirl.create(:permission)
            permission_role = FactoryGirl.create(:permissions_role,{permission: permission, role: role})
            
			get '/users'
			expect(last_response.status).to eq(200)
			json = last_response.body
			users = JSON.parse(json)
			expect(users.count).to eq(1)
			expect(User.new(users.first)).to eq(user)
            expect(users).to_not be(nil)
            expect(users.first).to_not be(nil)
            expect(users.first['area']).to eq(area)
			expect(users.first['areas_region'].first['region']).to eq(area)
			expect(users.first['household']).to eq(household)
			expect(users.first['interview'].count).to eq(1)
			expect(users.first['consumed_food']).to eq(consumed_food)
			expect(users.first['person']).to eq(person)
			expect(users.first['job']).to eq(job)			
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
