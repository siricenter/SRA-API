describe 'Users' do
	include RspecMixin
	context '/users' do
		it "returns a stringified array of all users the administrator can see" do
			user = FactoryGirl.create(:user)
			get '/users'
			expect(last_response.status).to eq(200)

			json = last_response.body
			users_list = JSON.parse(json)
			expect(users_list.count).to eq(1)
			expect(User.new(users_list.first)).to eq(user)
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
