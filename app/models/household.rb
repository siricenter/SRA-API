# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Household < ActiveRecord::Base
	has_many :people
	has_one :interview
	belongs_to :user # Interviewer
    
	accepts_nested_attributes_for :people
    
	validates :name, presence: true
	validates_presence_of :user
end
