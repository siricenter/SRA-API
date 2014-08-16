# == Schema Information
#
# Table name: interviews
#
#  id                  :integer          not null, primary key
#  household_id        :integer
#  roof                :string(255)
#  wall                :string(255)
#  floor               :string(255)
#  bedroom_count       :string(255)
#  separate_kitchen    :string(255)
#  light               :string(255)
#  fuel_type           :string(255)
#  water_source        :string(255)
#  water_chlorinated   :string(255)
#  bathroom            :string(255)
#  sewage              :string(255)
#  person_count        :string(255)
#  total_income        :string(255)
#  income_unit         :string(255)
#  shoe_cost           :string(255)
#  shoe_unit           :string(255)
#  medicine_cost       :string(255)
#  medicine_unit       :string(255)
#  school_cost         :string(255)
#  school_unit         :string(255)
#  college_cost        :string(255)
#  college_unit        :string(255)
#  water_electric_cost :string(255)
#  water_electric_unit :string(255)
#  misc_cost           :string(255)
#  misc_unit           :string(255)
#  radio               :string(255)
#  tv                  :string(255)
#  refrigerator        :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Interview < ActiveRecord::Base

	include InterviewDSL

	belongs_to :household
	has_many :consumed_foods

	define_nutrients :calories, :sugars_grams, :sodium_grams, :fat_grams, :protein_grams, :cholesterol_grams, :vitamin_a_dv, :vitamin_c_dv

	validates_presence_of :consumed_foods
end
