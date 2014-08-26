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

		it "returns 200 on valid query" do
			post '/session', @params
			expect(last_response.status).to eq(200)
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

		it "requires an email" do
			@params[:user][:email] = nil
			post '/session', @params
			expect(last_response.status).to eq(403)
		end

		it "requires a password" do
			@params[:user][:password] = nil
			post '/session', @params
			expect(last_response.status).to eq(403)
		end

		it "returns a randomly generated token"
		it "stores the given token in a database"
		it "associates the token with a user account"
	end
end
