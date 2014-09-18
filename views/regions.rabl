collection @regions
attributes *Area.column_names - ["created_at", "updated_at"], :object_root => false 

child :areas, :object_root => false  do
	attributes *Region.column_names - ["created_at", "updated_at"]
	
	child :users, :object_root => false do
	attributes *User.column_names - ["created_at", "updated_at"], :object_root => false 
	
	end
	
	child :households, :object_root => false do
	attributes *Household.column_names - ["interview", "created_at", "updated_at"], :object_root => false
    
    child :interview, :object_root => false do
    	attributes *Interview.column_names - ["consumed_foods", "created_at", "updated_at"], :object_root => false
    		
        child :consumed_foods, :object_root => false do
            attributes *ConsumedFood.column_names - ["created_at", "updated_at"], :object_root => false
        end
    end
	
    child :people, :object_root => false do
        attributes *Person.column_names - ["jobs", "created_at", "updated_at"], :object_root => false

        child :jobs, :object_root => false do 
            attributes *Job.column_names - ["created_at", "updated_at"], :object_root => false
        end
    end
end

