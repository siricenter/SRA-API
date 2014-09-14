object @roles
attributes, :object_root => false :id, :name

child :users,:object_root => false do
	attributes :email
end
