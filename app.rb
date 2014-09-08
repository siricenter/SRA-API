require 'uuid'
UUID.state_file = false
UUID.generator.next_sequence

require 'sinatra/activerecord'
require 'sinatra/base'

Dir["#{File.dirname(__FILE__)}/app/models/*.rb"].each {|file| require file}
Dir["#{File.dirname(__FILE__)}/routes/*.rb"].each {|file| require_relative file}

class API < Sinatra::Base
	
    register Sinatra::ActiveRecordExtension
	use Rack::Session::Cookie
    
    register Sinatra::API::Routing::Areas
    register Sinatra::API::Routing::Households
    register Sinatra::API::Routing::Interviews
    register Sinatra::API::Routing::Regions
    register Sinatra::API::Routing::Roles
    register Sinatra::API::Routing::Sessions
    register Sinatra::API::Routing::Users

end