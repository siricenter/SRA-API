object @households
attributes :id, :name, :object_root => false

child :people, :object_root => false do
    attributes :id, :given_name, :family_name

    child :jobs, :object_root => false do 
        attributes :title
    end
end

