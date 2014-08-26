describe 'Users' do
	include RspecMixin
    context '/users' do
        it "returns a stringified array of all users the user can see" do
            household = FactoryGirl.create(:users)
            get '/users'
			json = last_response.body
            users = JSON.parse(json)
            expect(users.count).to eq(1)
            expect(users.first['id']).to eq(user.id)
            expect(users.first['name']).to eq(user.name)
		end

        it "creates a new user" do
			expect {
                post '/users', {user: {email: 'test@gmail.com'}}
                }.to change(User, :count).by(1)
		end
        it "deletes a user" do
            expect{
                delete '/users', {user: {email: 'test@gmail.com'}}
                }.to change(User, :count).by(-1)
        end
         
	end
end
