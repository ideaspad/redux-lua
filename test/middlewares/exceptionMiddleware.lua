local exceptionMiddleware = function(store)
    return function(next)
        return function(action)
            print("exception ================>0")
            next(action)
            print("exception ================>1")
        end
    end
end

return exceptionMiddleware