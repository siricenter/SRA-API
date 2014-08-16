# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  given_name             :string(255)
#  family_name            :string(255)
#  family_relationship_id :integer
#  birthday               :date
#  education_level        :string(255)
#  gender                 :string(255)
#  in_school              :boolean
#  is_alive               :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  household_id           :integer
#

class Person < ActiveRecord::Base
	attr_accessible :birthday,
		:education_level,
		:family_name,
		:gender,
		:given_name,
		:in_school
	belongs_to :household
	belongs_to :family_relationship

	has_many :jobs

	validates :birthday, presence: true
	validates :education_level, presence: true
	validates :family_name, presence: true
	validates :gender, presence: true
	validates :given_name, presence: true
end
