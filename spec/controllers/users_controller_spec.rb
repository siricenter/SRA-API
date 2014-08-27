describe 'Users' do
	include RspecMixin
    context '/users' do
        it "returns a stringified array of all users the user can see" do
            users = FactoryGirl.create(:users)
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
         
	end
    
    context '/users/:id' do
        it "returns the desired stringified user object" do
            user = FactoryGirl.create(:user)
            get 'users/:id'
            json = last_response.body
            user = JSON.parse(json)
            expect(User.last).to eq(:user)
        end
        
        it "should delete the desired user" do
            user = FactoryGirl.create(:user)
            delete 'users/:id'
            user.destroy
            expect(User.last).to_be_nil
        end
    
        it "should update a desired user" do
            user = FactoryGirl.create(:user, email:"test@test.com")
            put 'users/#{user.to_param}', {user: {email: 'updated@test.com'}}
            user.reload
            expect(user.email).to eq("test1@test.com")
        end
    end
    
    
    
        
end
