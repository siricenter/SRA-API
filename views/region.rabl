object @region
attributes *Region.column_names

child :areas do
	attributes *Area.column_names
	
	child :users do
	    attributes *User.column_names
	end
	
	child :households do
	    attributes *Household.column_names
    
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