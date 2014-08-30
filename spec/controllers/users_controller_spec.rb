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

	context '/users/:id'
end
