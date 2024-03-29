# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
    has_many :areas, through: :areas_users
	has_many :areas_users
	has_and_belongs_to_many :roles

    has_many :areas_users
	has_many :events
	has_many :households
	has_many :tokens

	def has_role? role_name
        roles = self.roles.where(name: role_name.to_s)
		return false if roles.empty?
		return true
	end

	def area_role area
		self.areas_users.where(area: area).first.relationship
	end
end
