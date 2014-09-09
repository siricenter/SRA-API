# == Schema Information
#
# Table name: tokens
#
#  id           :integer
#  token_string :string
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Token < ActiveRecord::Base
	validates :token_string, presence: true
	belongs_to :user
end
