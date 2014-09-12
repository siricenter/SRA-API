object @area
attributes, :object_root => false :id, :name

child :regions,:object_root => false do
	attributes :name
end

child :users,:object_root => false do
	attributes :email
end
