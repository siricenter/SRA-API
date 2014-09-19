object @regions
attributes *Region.column_names - ["created_at", "updated_at"]

child :areas, :object_root => false  do
	attributes *Area.column_names - ["created_at", "updated_at"]
	
	child :users, :object_root => false do
	attributes *User.column_names - ["created_at", "updated_at"]
	
	end
	
	child :households, :object_root => false do
	attributes *Household.column_names - ["interview", "created_at", "updated_at"] 
    
    	child :interview, :object_root => false do
    		attributes *Interview.column_names - ["consumed_foods", "created_at", "updated_at"] 
    		
        	child :consumed_foods, :object_root => false do
            	attributes *ConsumedFood.column_names - ["created_at", "updated_at"] 
        	end
		end
		
    	child :people, :object_root => false do
        	attributes *Person.column_names - ["jobs", "created_at", "updated_at"] 
		
		 	child :jobs, :object_root => false do 
         	attributes *Job.column_names - ["created_at", "updated_at"]
		 
         	end
    	end
    end
end

