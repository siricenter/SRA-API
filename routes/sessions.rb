module Sinatra
    module API
        module Routing
            module Sessions
                def self.registered(app)
                    #Create a session
                    app.post '/session' do
                        #return 403 unless params[:key]
                        return 403 unless params[:user] and params[:user][:email] and params[:user][:password]
                        user = User.where(email: params[:user][:email]).first
                        return 403 unless user.password == params[:user][:password]
                        #return 403 unless ApiKey.exists?(key: params[:key])
<<<<<<< HEAD
                        uuid = UUID.new.generate
                        token = Token.new({token_string: uuid, user_id: user.id})
                        token.save!
                        return token.token_string
						
						
=======
                        #uuid = UUID.new.generate
                        #token = Token.new({token_string: uuid, user_id: user.id})
                        #token.save!
                        #return token.token_string
>>>>>>> b613f1bb7ade94ed627f976b0c128adabb620923
                    end
                end
            end
        end
    end
end