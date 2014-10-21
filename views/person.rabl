object @person
attributes :id, :given_name

child :job, :object_root => false do
	attributes :title
end

child :household, :object_root => false do
	attributes :name
end
end
 