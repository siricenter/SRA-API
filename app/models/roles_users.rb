# == Schema Information
#
# Table name: roles_users
#
#  id      :integer          not null, primary key
#  role_id :integer
#  user_id :integer
#

class RolesUsers < ActiveRecord::Base
    belongs_to :users
    belongs_to :roles
end
