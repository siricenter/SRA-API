require 'sinatra/activerecord'
require 'warden'
Dir["#{File.dirname(__FILE__)}/app/models/*.rb"].each {|file| require file}

class API < Sinatra::Base
	register Sinatra::ActiveRecordExtension
	use Rack::Session::Cookie
	
	#create new Area
	post '/areas' do
		area = Area.new(:name => params[:name])    
		area.save
	end

	#Create a user within an area
	post '/areas/users' do
		user = User.new({:email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation]})
		user.save
	end

	#Create a household within an area
	post '/areas/:id/households' do
		area = Area.find(params[:id])
		household = area.households <<  Household.new(:name => params[:household])        
		household.save
	end

	#Create an interview belonging to a specific user
	post '/areas/users/:id/interviews' do
		user = User.find(params[:id])
		interview = user.interviews << Interview.new
		interview.save
	end

	#To gather all the household belonging to all users within an area
	get '/areas/users/households' do
		@areas = Area.all
		@users = @areas.users
		@users.households.to_json
	end

	#Retreives all the households belonging to a specific user.
	get '/users/households' do
		@households = Household.all
		@user_households = user.households
		respond_to { |format|
			format.json { render :json => @user_households.to_json}
		}
	end

	#Retreives all the households within a specific area.
	get '/areas/:id/households' do
		Household.find_by(params[:id]).to_json
	end

	#retreives all the users 
	get '/users' do
		User.all.to_json
	end

	#Retreives a specifc user by the user_id
	get '/users/:id' do
		User.find_by(params[:id]).to_json
	end

	#Retreives the interviews belonging a specific user 
	get '/areas/users/:id/interviews' do
		Interview.find_by(params[:id]).to_json
	end

	#retreives all the interviews done in the specified area
	get '/areas/:id/interviews' do
		Interview.find_by(params[:id]).to_json
	end

	#Retreives the roles of the specified the user
	get '/areas/users/:id/roles' do
		user = User.find(:id)
		user.roles.to_json
	end

	#retreives all the areas
	get '/areas' do 
		areas = Area.all
		areas.to_json
	end

	#updates a specific household
	put '/areas/:id/households' do
		household = Household.find(params[:id])
		household.update(params[:household])
		household.save
	end

	#updates a specific user within an area
	put '/areas/users/:id' do
		user = User.find(params[:id])
		user.update(params[:user])
		user.save
	end

	#UPDATES a specified users roles
	put '/areas/users/:id/roles' do
		user = User.find(params[:id])
		role = user.roles
		role.update(:role)
		role.save
	end

	#updates a specific area
	put '/areas/:id' do
		area = Area.find(params[:id])
		area.update(:area)
		area.save
	end

	#destroys a specific area
	delete '/areas/:id' do
		area = Area.find(params[:id])
		area.delete
	end

	#destroys a specific user
	delete '/areas/user/:id' do
		user = User.find(params[:id])
		user.delete
	end

	#destroys a specific houehold belonging to specific user
	delete '/areas/users/:id/households/:household_id' do
		user = User.find(params[:id])
		household = user.housholds.where(id: :household_id)
		household.save    
	end

	#destroys a household
	delete '/areas/users/household/:id' do
		household = Household.find(:id)
		household.delete
	end

	#get "/login" do
	#	erb '/login'.to_sym
	#end

	# The call used when the user signs in. It will authenticate the User calling authenticate method defined below. 
	# If valid than redirect to /users path
	post "/session" do
		warden_handler.authenticate!
		if warden_handler.authenticated?
			redirect "/users/#{warden_handler.user.id}" 
		else
			redirect "/"
		end
	end

	#action for when user logs out.
	get "/logout" do
		warden_handler.logout
		redirect '/login'
	end

	post "/unauthenticated" do
		redirect "/"
	end

	use Warden::Manager do |manager|
		manager.default_strategies :password
		#manager.failure_app = SRA.rb
		manager.serialize_into_session {|user| user.id}
		manager.serialize_from_session {|id| User.find_by_id(id)}
	end

	Warden::Manager.before_failure do |env,opts|
		env['REQUEST_METHOD'] = 'POST'
	end

	Warden::Strategies.add(:password) do
		#validate the email and the password passed into warden
		def valid?
			params["email"] || params["password"]
		end
		#Authenticates the user 

		def authenticate!
			user = User.find_by_email(params["email"])
			if user && user.authenticate(params["password"])
				success!(user)
			else
				fail!("Could not log in")
			end
		end

		def warden_handler
			env['warden']
		end

		#stores the Authenticated user in the current_user object
		def current_user
			warden_handler.user
		end

		def check_authentication
			redirect '/login' unless warden_handler.authenticated?
		end
	end
end

