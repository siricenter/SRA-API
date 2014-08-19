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