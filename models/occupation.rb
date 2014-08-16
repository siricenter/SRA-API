# //@annotation:tour model-active-record-1
# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Occupation < ActiveRecord::Base
  attr_accessible :name
  has_many :jobs

  validates :name, presence: true
end
# //@annotation:/tour model-active-record-1