object @people
attributes *Person.column_names

child :jobs do
	attributes *Job.column_names
end

child :household do
	attributes *Household.column_names
end



