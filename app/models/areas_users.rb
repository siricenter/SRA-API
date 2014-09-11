# == Schema Information
#
# Table name: areas_users
#
#  id           :integer          not null, primary key
#  area_id      :integer
#  user_id      :integer
#  relationship :string(255)
#

class AreasUser < ActiveRecord::Base
    belongs_to :area
    belongs_to :user
end
