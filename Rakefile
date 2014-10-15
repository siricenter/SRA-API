require "sinatra/activerecord/rake"
require "./app"
begin
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end