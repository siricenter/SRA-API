require 'sinatra'
set :database_file, "./config/database.yml"
require 'sinatra/activerecord'
class API < Sinatra::Base
	register Sinatra::ActiveRecordExtension
	use Rack::Session::Cookie

	post '/areas' do
		area = Area.new(:name => params[:name])    
		area.save
	end

	post '/areas/users' do
		user = User.new({:email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation]})
		user.save
	end

	post '/areas/:id/households' do
		area = Area.find(params[:id])
		household = area.households <<  Household.new(:name => params[:household])        
		household.save
	end

	post '/areas/users/:id/interviews' do
		user = User.find(params[:id])
		interview = user.interviews << Interview.new
		interview.save
	end

	get '/areas/users/households' do
		@areas = Area.all
		respond_to { |format|
			format.json { rend
				 er :json => @areas.to_json }
		}
	end

	get '/users/households' do
		@households = Household.all
		@user_households = user.households
		respond_to { |format|
			format.json { rend
				 er :json => @user_households.to_json}
		}
	end

	get '/areas/:id/households' do
		Household.find_by(params[:id]).to_json
	end

	get '/users/:id/households' do
		Household.find_by(params[:id]).to_json
	end

	get '/users' do
		User.all.to_json
	end

	get '/users/:id' do
		User.find_by(params[:id]).to_json
	end

	get '/areas/users/:id/interviews' do
		Interview.find_by(params[:id]).to_json
	end

	get '/areas/:id/interviews' do
		Interview.find_by(params[:id]).to_json
	end

	get '/areas/users/:id/roles' do
		user = User.find(:id)
		user.roles.to_json
	end
    
    get '/areas' do 
        areas = Area.all
        areas.to_json
    end


	put '/areas/:id/households' do
		household = Household.find(params[:id])
		household.update(params[:household])
		household.save
	end

	put '/areas/users/:id' do
		user = User.find(params[:id])
		user.update(params[:user])
		user.save
	end

	put '/areas/users/:id/roles' do
		user = User.find(params[:id])
		role = user.roles
		role.update(:role)
		role.save
	end

	put '/areas/:id' do
		area = Area.find(params[:id])
		area.update(:area)
		area.save
	end


	delete '/areas/:id' do
		area = Area.find(params[:id])
		area.delete
	end

	delete '/areas/user/:id' do
		user = User.find(params[:id])
		user.delete
	end

	delete '/areas/users/:id/households/:household_id' do
		user = User.find(params[:id])
		household = user.housholds.where(id: :household_id)
		household.save    
	end

	delete '/areas/users/household/:id' do
		household = Household.find(:id)
		household.delete
	end

	get "/login" do
		erb '/login'.to_sym
	end


	post "/session" do
		warden_handler.authenticate!
		if warden_handler.authenticated?
			redirect "/users/#{warden_handler.user.id}" 
		else
			redirect "/"
		end
	end


	get "/logout" do
		warden_handler.logout
		redirect '/login'
	end


	post "/unauthenticated" do
		redirect "/"
	end


	use Warden::Manager do |manager|
		manager.default_strategies :password
		manager.failure_app = SRA.rb
		manager.serialize_into_session {|user| user.id}
		manager.serialize_from_session {|id| User.find_by_id(id)}
	end


	Warden::Manager.before_failure do |env,opts|
		env['REQUEST_METHOD'] = 'POST'
	end


	Warden::Strategies.add(:password) do
		def valid?
			params["email"] || params["password"]
		end


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

		def current_user
			warden_handler.user
		end

		def check_authentication
			redirect '/login' unless warden_handler.authenticated?
		end
	end
end

