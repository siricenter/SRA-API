# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  start      :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
	belongs_to :user
	attr_accessible :start, :title

	validates :start, presence: true
	validates :title, presence: true
end
