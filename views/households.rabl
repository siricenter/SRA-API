object @households
attributes :id, :name, :object_root => false

child :people do
    attributes :id, :given_name, :family_name

    child :jobs do 
        attributes :title
    end
end

