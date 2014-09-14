object @household
attributes :id, :name, :object_root => false

child :people, :object_root => false do
	attributes :given_name, family_name
end

child :jobs, :object_root => false do
	attributes :name
end
