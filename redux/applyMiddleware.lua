local applyMiddleware = function(...)
    local middlewares = {...}
    return function(oldCreateStore)
        return function(reducer, initState)
            local store = oldCreateStore(reducer, initState)
            local next = store.dispatch
            local temp = nil
            for _, middleware in ipairs(middlewares) do
                local func = middleware(store)
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

