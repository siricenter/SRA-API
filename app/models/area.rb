# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ActiveRecord::Base
  has_many :users, through: :areas_users
  has_and_belongs_to_many :regions, through: :areas_regions
  has_many :areas_users
  has_many :areas_regions
  has_many :households

  validates :name, presence: true
end
