class Token < ActiveRecord::Base
	validates :token_string, presence: true
end
