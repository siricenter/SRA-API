# == Schema Information
#
# Table name: areas_regions
#
#  id           :integer          not null, primary key
#  area_id      :integer
#  region_id    :integer
#

class AreasRegion < ActiveRecord::Base
    belongs_to :area
    belongs_to :region
end
