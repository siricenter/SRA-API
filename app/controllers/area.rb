module Area
    post "/area" do
        @area = Area.new(params[:area])
        
        String 
        
    end
    get "/area/:id" do
        Area.find(params[:id]).to_json(include: [:users, :roles])
    end
    put "/area/:id" do
        Area.find(params[:id])
    end
    delete "/area/:id" do
        
    end
end