object @role
attributes *Role.column_names - ["created_at", "updated_at"], :object_root => false 


child :users, :object_root => false do
	attributes *User.column_names - ["created_at", "updated_at"], :object_root => false 
	
	child :area, :object_root => false do
	attributes *Area.column_names - ["interview", "created_at", "updated_at"], :object_root => false
	
		child :households, :object_root => false do
		attributes *Households.column_names - ["created_at", "updated_at"]
	
			child :interview, :object_root => false do
    		attributes *Interview.column_names - ["consumed_foods", "created_at", "updated_at"], :object_root => false
    		
        		child :consumed_foods, :object_root => false do
           		 attributes *ConsumedFood.column_names - ["created_at", "updated_at"], :object_root => false
				 
				 end
			end
			
        end
	
    end	
    	
end


    
    
