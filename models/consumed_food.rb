# == Schema Information
#
# Table name: consumed_foods
#
#  id           :integer          not null, primary key
#  interview_id :integer
#  n_id         :string(255)
#  servings     :integer
#  frequency    :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_consumed_foods_on_interview_id  (interview_id)
#

class ConsumedFood < ActiveRecord::Base
	include ConsumedFoodDSL
	belongs_to :interview
	attr_accessible :frequency, :n_id, :servings
	nutrients calories: "nf_calories", 
		sugars_grams: "nf_sugars", 
		fat_grams: "nf_total_fat", 
		sodium_grams: "nf_sodium", 
		protein_grams: "nf_protein", 
		cholesterol_grams: "nf_cholesterol", 
		vitamin_a_dv: "nf_vitamin_a_dv",
		vitamin_c_dv: "nf_vitamin_c_dv"

	validates :n_id, presence: true
	validates :servings, presence: true, numericality: {greater_than: 0}
	validates :frequency, inclusion: {in: %w{daily weekly monthly}}

	def name
		get_data["item_name"]
	end
end
