object @person
attributes :id, :given_name

child :jobs, :object_root => false do
	attributes :title
end

child :household, :object_root => false do
	attributes :name
end
 