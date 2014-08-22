set :enviroment, :test

def app
	Sinatra::Application
end

describe User do
    subject {FactoryGirl.create(:user)}
    context '/areas/users/:id' do
		it "should have a valid factory" do
			expect(subject).to be_valid
		end
	end
end