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
