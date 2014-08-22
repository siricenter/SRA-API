set :enviroment, :test

def app
	Sinatra::Application
end

describe Interview do
    subject {FactoryGirl.create(:interview)}
    context '/areas/users/housholds/interview/:id' do
		it "should have a valid factory" do
			expect(subject).to be_valid
		end
	end
end