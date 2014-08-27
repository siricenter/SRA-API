class CreateTokens < ActiveRecord::Migration
  def change
	  create_table :tokens do |t|
		  t.string :token_string
		  t.references :user

		  t.timestamps
	  end
  end
end
