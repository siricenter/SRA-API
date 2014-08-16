require 'rubygems'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'bcrypt'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db.sqlite")

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial, :key => true
  property :username, String, :length => 3..50
  property :password, BCryptHash
end

DataMapper.finalize
DataMapper.auto_upgrade!
def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end