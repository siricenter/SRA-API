# == Schema Information
#
# Table name: jobs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  seasonal      :boolean
#  description   :string(255)
#  person_id     :integer
#  occupation_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Job < ActiveRecord::Base
	attr_accessible :description, :seasonal, :title, :occupation
	belongs_to :person
	belongs_to :occupation

	validates_presence_of :person
	validates_presence_of :occupation
end
