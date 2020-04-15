local applyMiddleware = function(...)
    local middlewares = {...}
    return function(oldCreateStore)
        return function(reducer, initState)
            local store = oldCreateStore(reducer, initState)
            local simpleStore = {getState =  store.getState}
            local next = store.dispatch
            local temp = nil
            for index = #middlewares, 1, -1 do
                local middleware= middlewares[index]
                local func = middleware(simpleStore)
                if temp == nil then
                    temp = func(next)
                else
                    temp = func(temp)
                end
            end
            store.dispatch = temp or next
            return store
        end
    end
end

return applyMiddleware

