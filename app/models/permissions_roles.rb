# == Schema Information
#
# Table name: permissions_roles
#
#  id             :integer          not null, primary key
#  permission_id  :integer
#  role_id        :integer
#

class PermissionsRole < ActiveRecord::Base
    belongs_to :permission
    belongs_to :role
end
