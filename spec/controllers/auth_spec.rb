describe 'auth' do
	include RspecMixin

	describe 'login' do
		before :each do
			@user = FactoryGirl.create(:user)
			@params = {
				key: '0000', 
				user: {
					email: @user.email,
					password: @user.password
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

		it "returns a randomly generated token" do
			# For now, we'll just use a hard coded value
			post '/session', @params
            token = double(Token)
            allow(token).to receive(:token_string) {'TOKEN1000'}
            expect(token.token_string).to eq('TOKEN1000')
		end  

		it "stores the given token in a database" do
			expect {
				post '/session', @params
			}.to change(Token, :count).by(1)
		end

		it 'requires the email/password combination to be valid' do
			@params[:user][:password] = 'randomwrongpassword01'
			post '/session', @params
			expect(last_response.status).to eq(403)
		end

		it "associates the token with a user account" do
			post '/session', @params
			expect(Token.last.user).to eq(@user)
		end
	end
end
