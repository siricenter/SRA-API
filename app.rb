require 'sinatra'
set :database_file, "./config/database.yml"
require 'sinatra/activerecord'
require './get'
#require './post'
#require './delete'
#require './put'
#require './login'
class API < Sinatra::Base
	register Sinatra::ActiveRecordExtension

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
			format.json { render :json => @areas.to_json }
		}
	end
	get '/users/households' do
		@households = Household.all
		@user_households = user.households
		respond_to { |format|
			format.json { render :json => @user_households.to_json}
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
end