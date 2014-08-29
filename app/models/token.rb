class Token < ActiveRecord::Base
	validates :token_string, presence: true
	belongs_to :user
end
