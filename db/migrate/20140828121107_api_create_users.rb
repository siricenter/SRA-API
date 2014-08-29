class ApiCreateUsers < ActiveRecord::Migration
  def change
	  create_table :users do |t|
		  # This is a *very* temporary solution to just get unit tests passing,
		  # so authentication doesn't terribly hold up development. We will add
		  # encryption and everything very shortly.
		  t.string :email
		  t.string :password
	  end
  end
end
