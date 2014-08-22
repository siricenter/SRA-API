set :enviroment, :test

def app
	Sinatra::Application
end

describe Area do
	subject {FactoryGirl.create(:area)}
	context '/areas' do
		it "should have a valid factory" do
			expect(subject).to be_valid
		end
	end
end

#describe 'Get areas index' do
#	include Rack::Test::Methods
#	it 'Should return all areas' do
#		get '/areas'
#		areas should == Area.all
#	end
#end
#
#
#describe 'Get area/users index' do
#	include Rack::Test::Methods
#	it 'Should return all users belonging to an area' do
#		get 'areas/:id/users'
#		@area = Area.new
#		@area.name "Rexburg"
#
#		@user = User.new
#		@user.name "Andrew"
#		@user.area(@area)
#
#		@area.user should == @user
#
#	end
#end
#
#describe 'Get area/users/households index' do
#	include Rack::Test::Methods
#	it 'Should return the households of a user' do
#		get 'areas/users/:id/households' do
#			@area = Area.new
#			@area.name "Rexburg"
#
#			@user = User.new
#			@user.name "Andrew"
#			@user.area(@area)
#		end
#	end
#end
