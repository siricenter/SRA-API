require 'uuid'
UUID.state_file = false
UUID.generator.next_sequence
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
        return 403 unless ApiKey.exists?(key: params[:key])
        uuid = UUID.new.generate
        token = Token.new({token_string: uuid, user_id: user.id})
		token.save!
		return token.token_string
	end

	# Create a new Area
	post '/areas' do
		area = Area.new(params[:area])    
		area.save!
		return {id: area.id}.to_json
	end
    #Retreive an area
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

	

	
    #Retreive all households
	get '/households' do
		Household.all.to_json
	end
    #create a Household
	post '/households' do
		{id: Household.create!(params[:household]).to_param}.to_json
	end
    #retreive a household
	get '/households/:id' do
		Household.find(params[:id]).to_json
	end
    #update a household
	put '/households/:id' do
		household = Household.find(params[:id])
		household.update(params[:household])
	end
    #delete a household
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
    #create a user
	post '/users' do
		User.create!(params[:user])
	end

	#Retreives a specifc user by the user_id
	get '/users/:id' do
		User.find(params[:id]).to_json
	end
    #update a user
	put '/users/:id' do
		User.find(params[:id]).update(params[:user])
	end
    #delete a user
	delete '/users/:id' do
		User.find(params[:id]).destroy
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
    #retreives all regions
	get '/regions' do
		Region.all.to_json
	end
    #create a region
	post '/regions' do
		region = Region.create(params[:region])
		{id: region.id}.to_json
	end
    #Retreive a region
	get '/regions/:id' do
		Region.find(params[:id]).to_json
	end
    #update a Region
	put '/regions/:id' do
		Region.find(params[:id]).update(params[:region]).to_json
	end
    #update a region
	delete '/regions/:id' do
		Region.find(params[:id]).destroy
	end

	get '/roles' do
		Role.all.to_json
	end

	post '/roles' do
		{id: Role.create(params[:role]).id}.to_json
	end

	get '/roles/:id' do
		Role.find(params[:id]).to_json
	end

	put '/roles/:id' do
		Role.find(params[:id]).update(params[:role]).to_json
	end

	delete '/roles/:id' do
		Role.find(params[:id]).destroy
	end

	get '/interviews' do
		Interview.all.to_json
	end

	post '/interviews' do
		{id: Interview.create(params[:interview]).id}.to_json
	end

	get '/interviews/:id' do
		Interview.find(params[:id]).to_json
	end

	put '/interviews/:id' do
		Interview.find(params[:id]).update(params[:interview])
	end

	delete '/interviews/:id' do
		Interview.find(params[:id]).destroy
	end
end

