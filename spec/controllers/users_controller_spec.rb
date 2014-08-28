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
        
        it "updates all users" do
        end
        
        it "deletes all users" do
        end
	end
    
    context '/users/:id' do
        it "returns the desired stringified user object" do
            joey = FactoryGirl.create(:user)
            get "users/#{joey.to_param}"
            json = last_response.body
            joey = JSON.parse(json)
            expect(User.last).to eq(joey)
        end
        
        it "should delete the desired user" do
            user = FactoryGirl.create(:user)
            delete "users/#{user.to_param}"
            user.destroy
            expect(User.last).to_be_nil
        end
    
        it "should update a desired user" do
            user = FactoryGirl.create(:user, email:"test@test.com")
            put "/users/#{user.to_param}", {user: {email: 'updated@test.com'}}
            user.reload
            expect(user.email).to eq("test1@test.com")
        end
    end
    context '/users/:id/areas' do 
        it 'Should return the areas associated with that user' do
            user = FactoryGirl.create(:user)
            area = user.areas << Area.new
            get "/users/#{user.to_param}/areas"
            expect(areas.count).to eq(1)
        end
        it 'Should assign a area to user' do
            user = FactoryGirl.create(:user)
            area = user.areas << Area.new(name: "Rexburg")
            put "/users/#{user.to_param}/areas"
            expect(user.areas).to eq(1)
            expect(user.areas.name).to eq("Rexburg")
        end
    end
    context '/users/:id/households' do
        it "should return all the households for that user" do
       		user = FactoryGirl.create(:user)
        	household = FactoryGirl.create(:household, name: "Johnson")
        	user.housholds << household
        	get "/users/#{user.to_param}/households"
        	expect(user.households).to eq(1)
    	end
        it 'Should delete the households for that user ' do
            user = FactoryGirl.create(:user)
            household = FactoryGirl.create(:household, name:"Johnson")
            user.households << household
            delete "/users/#{user.to_param}/households"
            expect(user.households).to_be_nil
        end
    end
    context '/users/households/:id' do
        it "should delete a houshold for a user" do
            user = FactoryGirl.create(:user)
            household = FactoryGirl.create(:household, name: "Johnson")
            user.households << household
            delete "/users/households/#{household.param}"
            expect(user.households).to_be_nil
        end
        it "should update a area for user" do
            user = FactoryGirl.create(:user)
            household = FactoryGirl.create(:household, name: "Johnson")
            user.households << household
            put "/users/#{household.to_param}", {household: {name: 'Wilson'}}
            expect(user.households[0].name).to eq("Wilson")
            expect(user.households.count).to eq(1)
        end
            
    end
end
