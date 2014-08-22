set :enviroment, :test

def app
	Sinatra::Application
end

describe Household do
    subject {FactoryGirl.create(:household)}
    context '/areas/users/household/:id' do
		it "should have a valid factory" do
			expect(subject).to be_valid
		end
	end
end