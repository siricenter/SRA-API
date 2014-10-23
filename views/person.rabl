object @person
attributes :id, :given_name, :birthday, :education_level, :gender, :in_school, :is_alive

child :jobs, :object_root => false do
	attributes :title
end

child :household, :object_root => false do
	attributes :name
end

child :family_relationship, :object_root => false do
	attributes :id, :name
end
	

 