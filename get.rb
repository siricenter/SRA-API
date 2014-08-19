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