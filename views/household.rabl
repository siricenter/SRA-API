object @household
attributes :id, :name, :object_root => false

child :people do
    attributes :id, :given_name

    child :jobs do 
        attributes :title
    end
end

child :interview do
	attributes :id
	
	child :consumed_foods do
		attributes :n_id, :servings, :frequency
	end
end



