require 'rubygems'
require 'bundler'
Bundler.require
$stdout.sync
require 'sinatra'
set :database_file, "#{File.dirname(__FILE__)}/config/database.yml"
require './app'
run API
