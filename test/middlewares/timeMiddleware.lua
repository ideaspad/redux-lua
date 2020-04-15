local timeMiddleware = function(store)
    return function(next)
        return function(action)
            print("time ================>0")
            next(action)
            print("time ================>1")
        end
    end
end

return timeMiddleware