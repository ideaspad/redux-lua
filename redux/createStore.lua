local createStore = nil
createStore = function(reducer, initState, rewriteCreateStoreFunc)
    if rewriteCreateStoreFunc then
        local newCreateStore = rewriteCreateStoreFunc(createStore)
        return newCreateStore(reducer, initState)
    end

    local state = initState
    local listeners = {}
    local subscribe = function(listener)
        table.insert(listeners, listener)
    end
    local dispatch = function(action)
        state = reducer(state, action)
        for index, value in ipairs(listeners) do
            local listener = listeners[index]
            listener()
        end
    end
    local getState = function()
        return state
    end

    dispatch({type = ''})

    return {
        subscribe = subscribe,
        dispatch = dispatch,
        getState = getState,
    }
end

return createStore