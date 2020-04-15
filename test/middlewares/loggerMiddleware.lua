local loggerMiddleware = function(store)
    return function(next)
        return function(action)
            print("log ================>0")
            next(action)
            print("log ================>1")
        end
    end
end

return loggerMiddleware