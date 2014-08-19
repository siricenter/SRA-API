module UserLogin
    
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
    