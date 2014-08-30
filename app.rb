require 'sinatra/activerecord'
Dir["#{File.dirname(__FILE__)}/app/models/*.rb"].each {|file| require file}

class API < Sinatra::Base
	register Sinatra::ActiveRecordExtension
	use Rack::Session::Cookie

	post '/session' do
		return 403 unless params[:key]
		return 403 unless params[:user] and params[:user][:email] and params[:user][:password]
		user = User.where(email: params[:user][:email]).first
		return 403 unless user.password == params[:user][:password]
		token = Token.new({token_string: 'TOKEN1000', user: user})
		token.save!
		return token.token_string
	end
	
	# Create a new Area
	post '/areas' do
		area = Area.new(params[:area])    
		area.save!
		return {id: area.id}.to_json
	end

	get '/areas/:id' do
		Area.find(params[:id]).to_json
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

	get '/households' do
		Household.all.to_json
	end

	post '/households' do
		{id: Household.create!(params[:household]).to_param}.to_json
	end

	get '/households/:id' do
		Household.find(params[:id]).to_json
	end

	put '/households/:id' do
		household = Household.find(params[:id])
		household.update(params[:household])
	end

	delete '/households/:id' do
		Household.find(params[:id]).destroy
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

	post '/users' do
		User.create!(params[:user])
	end

	#Retreives a specifc user by the user_id
	get '/users/:id' do
		User.find(params[:id]).to_json
	end

	put '/users/:id' do
		User.find(params[:id]).update(params[:user])
	end

	delete '/users/:id' do
		User.find(params[:id]).destroy
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
		area.update(params[:area])
		area.save
	end

	#destroys a specific area
	delete '/areas/:id' do
		area = Area.find(params[:id])
		area.destroy
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

	get '/regions' do
		Region.all.to_json
	end
end

