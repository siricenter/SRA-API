class CreateApiKeyTable < ActiveRecord::Migration
  def change
  	create_table :api_key do |t|
  	 	  t.string :key
		  t.string :app_name
		  t.string :type
		  t.string :owner
	  end
  end
end
