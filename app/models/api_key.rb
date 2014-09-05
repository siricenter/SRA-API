# == Schema Information
#
# Table name: areas
#
#  id         :integer
#  key        :string
#  app_name   :string
#  type       :string
#  owner      :sting
#  created_at :datetime
#  updated_at :datetime
#

class ApiKey < ActiveRecord::Base
	validates :key, :app_name, :type, :owner, presence: true
end
