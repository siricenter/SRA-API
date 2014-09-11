# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Region < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :areas, through: :areas_regions
  has_many :areas_regions
end
