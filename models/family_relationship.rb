# == Schema Information
#
# Table name: family_relationships
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FamilyRelationship < ActiveRecord::Base
  attr_accessible :name
  has_many :people
  validates :name, presence: true
end
