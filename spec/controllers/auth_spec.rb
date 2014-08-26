describe 'auth' do
	include RspecMixin

	describe 'login' do
		before :each do
			@user = FactoryGirl.create(:user)
			@params = {
				key: '0000', 
				user: {
					email: 'test@test.com',
					password: 'password01'
				}
			}
		end

		it "requires an api key to work" do
			@params[:key] = nil
			post '/session', @params
			expect(last_response.status).to eq(403)
		end

		it "requires login credentials to work" do
			@params[:user] = nil
			post '/session', @params
			expect(last_response.status).to eq(403)
		end

		it "requires an email"
		it "requires a password"
		it "returns a randomly generated token"
		it "stores the given token in a database"
		it "associates the token with a user account"
	end
end
