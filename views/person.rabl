object @person
attributes *Person.column_names

child :jobs, :object_root => false do
	attributes *Job.column_names
end

child :household, :object_root => false do
	attributes *Household.column_names
end

child :family_relationship, :object_root => false do
	attributes *FamilyRelationship.column_names
end
	

 