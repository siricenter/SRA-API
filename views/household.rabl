object @household
attributes *Household.column_names

child :people do
    attributes *Person.column_names

    child :jobs do 
        attributes *Job.column_names
    end
end

child :interview do
	attributes *Interview.column_names
	
	child :consumed_foods do
		attributes *ConsumedFood.column_names
	end
end