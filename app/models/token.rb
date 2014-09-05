require 'uuid'
UUID.state_file = false
UUID.generator.next_sequence

class Token < ActiveRecord::Base
	validates :token_string, presence: true
	belongs_to :user
end
