describe 'auth' do
	include RspecMixin

	describe 'login' do
		it "requires an api key to work"
		it "requires login credentials to work"
		it "returns a randomly generated token"
		it "stores the given token in a database"
		it "associates the token with a user account"
	end
end
