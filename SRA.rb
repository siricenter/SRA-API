require "sinatra/activerecord"

user = current_user
get '/users/households' do
    households = Household.all
    user.households.to_json
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
post '/areas' do
    Area.new(params[:name])    
end
post '/areas/users' do
    User.new({:email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation]}
end
post '/areas/:id/households' do
    area = Area.find(params[:id])
    area.households <<  Household.new(:name => params[:household])        
end
post '/areas/users/:id/interviews' do
    
    
    


