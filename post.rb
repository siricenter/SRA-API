module PostInfo
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
end