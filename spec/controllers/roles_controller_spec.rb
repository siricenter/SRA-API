describe 'Roles' do
    include RspecMixin
    context '/roles' do
        it "returns a list of all the existing roles" do
            role = FactoryGirl.create(:role)
            get '/roles'
            json = last_response.body
            roles_js = JSON.parse(json)
			retrieved_role = Role.new(roles_js.first)
            expect(retrieved_role).to eq(role)
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
            expect(role_js['id']).to eq(role.id)
            expect(role_js['name']).to eq(role.name)
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
    
        
