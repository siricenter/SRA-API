object @people
attributes :id, :given_name, :object_root => false

child :jobs, :object_root => false do
	attributes :title
end

child :household, :object_root => false do
	attributes :name
end



