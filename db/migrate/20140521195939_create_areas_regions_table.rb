class CreateAreasRegionsTable < ActiveRecord::Migration
  def change
	  create_table :areas_regions do |t|
		  t.references :area
		  t.references :region
	  end
  end
end
