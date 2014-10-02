collection @households
attributes :id, :name, :object_root => false

child :people, :object_root => false do
    attributes :id, :given_name, :family_name

    child :jobs, :object_root => false do 
        attributes :title
    end
end

child :interview do
	attributes :id
	
	child :consumed_foods do
		attributes :n_id, :servings, :frequency
	end
end


