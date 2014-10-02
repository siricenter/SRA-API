describe 'Roles' do
    include RspecMixin
    context '/roles' do
        it "returns a list of all the existing roles" do
            role = FactoryGirl.create(:role)
			#permissions_role = FactoryGirl.create(:permission_role, {role: role})
			#permission = FactoryGirl.create(:permission, {permission: permission})
			#role_user = FactoryGirl.create(:roles_users, {role: role})
			#user = FactoryGirl.create(:user,{roles_users: role_user})
			#area_user = FactoryGirl.create(:areas_users,{user: user})
			#area = FactoryGirl.create(:area,{areas_users: area_user})
			#area_region = FactoryGirl.create(:areas_regions, {area: area})
			#region = FactoryGirl.create(:region,{areas_regions: areas_regions})
			#household = FactoryGirl.create(:household,{area: area})
			#interview = FactoryGirl.create(:interview,{household: household})
			#consumed_food = FactoryGirl.create(:consumed_food,{interview: interview})
			#person = FactoryGirl.create(:person,{household: household})
			#job = FactoryGirl.create(:job,{person: person})
            get '/roles'
            json = last_response.body
			roles = JSON.parse(json)
			expect(roles.first['role']['id']).to eq(role.id)
			expect(roles.first['role']['name']).to eq(role.name)
			
        end

		it "creates a new role" do
			expect {
				post '/roles', {role: {name: 'doctor'}}
			}.to change(Role, :count).by(1)
		end

		it "returns the id of the created role" do
			post '/roles', {role: {name: 'doctor'}}
			json = last_response.body
			id_response = JSON.parse(json)
			expect(id_response).to eq({'id' => Role.last.id})
		end
    end

    context '/roles/:id' do
        it "return an existing role" do
            role = FactoryGirl.create(:role)
            get "/roles/#{role.to_param}"
            json = last_response.body
            role_js = JSON.parse(json)
			expect(role_js['role']['name']).to eq(role.name)
			expect(role_js['role']['id']).to eq(role.id)
        end

		it "updates an existing role" do
            role = FactoryGirl.create(:role)
            put "/roles/#{role.to_param}", {role: {name: 'slacker'}}
			role.reload
			expect(role.name).to eq('slacker')
		end

        it "deletes an existing role" do
            role = FactoryGirl.create(:role)
			expect {
				delete "/roles/#{role.to_param}"
			}.to change(Role, :count).by(-1)
        end
    end
end
    
        
