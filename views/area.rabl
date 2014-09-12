object @area
attributes :id, :name

child :regions do
	attributes :name
end

child :users do
	attributes :email
end
