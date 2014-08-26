class Token < ActiveRecord::Base
	validates :token, presence: true
	validates_presence_of :user
end
