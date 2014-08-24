# == Schema Information
#
# Table name: area_relationships
#
#  id           :integer          not null, primary key
#  area_id      :integer
#  user_id      :integer
#  relationship :string(255)
#

class AreaRelationship < ActiveRecord::Base
    belongs_to :area
    belongs_to :user
end
