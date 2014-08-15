
get '/dasboards' do
        @households = Household.all
    	@user = current_user
        if @user.has_role? "admin"
            redirect_to '/dashboard/admin'
        elsif @user.has_role? "manager"
            redirect_to 'dashboard/field_worker'
        elsif @user.has_role? "field worker"
            redirect_to 'dashboard/field_worker'
		else
            redirect_to '/households'
        end
	end
get '/dashboards/field_worker' do
       @households = @user.households
    if @user.has_role? "manager"
       @field_workers = @user.area_relationships.select{|r| r.relationship == "Manager"}.map{|r| r.area}.map{|area| area.area_relationships.select{|r|r.relationship == "Field Worker"}.map{|r| r.user}}.flatten
       @areas = Area.joins(:users).where(area_relationships:{relationship: "Manager"},users:{id: @user.id})
    end
       render :worker
	end
get '/dashboards/admin' do
    @user = current_user
    if @user.has_role? "admin"
        @user = User.new
        @users = User.all
    else
        @message = "You do not have rights to access this page"
        redirect_to '/'
    end
end

