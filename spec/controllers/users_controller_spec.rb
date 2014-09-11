describe 'Users' do
	include RspecMixin

	context '/users' do
		it "returns a stringified array of all users the administrator can see" do
			user = FactoryGirl.create(:user)
			area_user = FactoryGirl.create(:areas_users, {user: user})
			area = FactoryGirl.create(:area,{areas_users: areas_users})
			area_region = FactoryGirl.create(:areas_regions,{area: area})
			region = FactoryGirl.create(:region,{area_region: area_region})
			household = FactoryGirl.create(:household,{area: area})
			interview = FactoryGirl.create(:interview,{household: household})
			consumed_foods = FactoryGirl.create(:consumed_foods,{interview: interview})
			person = FactoryGirl.create(:person,{household: household})
			job = FactoryGirl.create(:job, {person: person})
			events = FactoryGirl.create(:event, {user: user})
			role_user = FactoryGirl.create(:roles_users, {user: user})
			role = FactoryGirl.create(:role, {roles_user: role_user})
			permission_role = FactoryGirl.create(:permission_role,{role: role})
			permission = FactoryGirl.create(:permission, {permission_role: permission_role})
			get '/users'
			expect(last_response.status).to eq(200)
			json = last_response.body
			users_list = JSON.parse(json)
			expect(users_list.count).to eq(1)
			expect(User.new(users_list.first)).to eq(user)
			expect(user_list.first['area_user'].first['area']).to eq(area)
			expect(user_list.first['area']).to eq(area)
			expect(user_list.first['area_region'].first['region']).to eq(area)
			expect(user_list.first['household']).to eq(household)
			expect(user.list.first['interview'].count).to eq(1)
			expect(user.list.first['consumed_foods']).to eq(consumed_foods)
			expect(user_list.first['person']).to eq(person)
			expect(user_list.first['job']).to eq(job)			
		end

		it "creates a new User" do
			expect{
				post '/users', {
					user: {
						email: Faker::Internet.email,
						password: Faker::Internet.password
					}
				}
			}.to change(User, :count).by(1)
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
