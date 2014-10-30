# == Schema Information
#
# Table name: roles_users
#
#  id      :integer          not null, primary key
#  role_id :integer
#  user_id :integer
#

class RolesUser < ActiveRecord::Base
    belongs_to :user
    belongs_to :role
end
