require 'sinatra'
require "sinatra/activerecord"
require 'warden'
require 'get'
require 'post'
require 'delete'
require 'put'
require 'login'

Class API < Sinatra::Application
	use Rack::Session::Cookie


end