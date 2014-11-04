object @people
attributes :id, :given_name, :updated_at, :created_at, :object_root => false

child :jobs, :object_root => false do
	attributes :title
end

child :household, :object_root => false do
	attributes :name
end



