object @role
attributes *Role.column_names

child :users do
	attributes *User.column_names
	
	child :area do
	    attributes *Area.column_names
	
		child :households do
		    attributes *Households.column_names
	
			child :interview do
    		    attributes *Interview.column_names
    		
        		child :consumed_foods do
           		    attributes *ConsumedFood.column_names
				 end
			end
			
			child :people do
			    attributes *Person.column_names
			
				child :jobs do
				    attributes *Job.column_names
				end
			end
        end
    end
end