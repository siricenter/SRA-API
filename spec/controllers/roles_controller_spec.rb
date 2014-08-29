describe 'Roles' do
    include RspecMixin
    context '/roles' do
        it "should return a list of all the existing roles" do
            roles = FactoryGirl.create(:role)
            get '/roles'
            json = last_response.body
            roles_js = JSON.parse(json)
            expect(roles_js['id']).to eq(roles.id)
            expect(roles_js['name']).to eq(roles.name)
        end
        it "should delete all the existing roles" do
            roles = FactoryGirl.create(:role)
            delete '/roles'
            roles.destroy
            expect(roles.count).to eq(0)
        end
        it "should update all the existing roles" do
            roles = FactorGirl.create(:roles)
            put '/roles' {roles: {name: 'admin'}}
            expect(roles.name).to eq("admin")    
        end
    end
    context '/roles/:id' do
        it "return an existing role" do
            role = FactoryGirl.create(:role)
            get '/roles/:id'
            json = last_response.body
            role_js = JSON.parse(json)
            expect(role_js['id']).to eq(role.id)
            expect(role_js['name']).to eq(role.name)
        end
        it" delete an existing role" do
            role = FactoryGirl.create(:role)
            delete '/roles/:id'
            role.destroy
            expect(role.count).to eq(0)
        end
    end
end
    
        