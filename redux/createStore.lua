local function createStore(reducer, initState, rewriteCreateStoreFunc)
    if type(initState) == 'function' then
        rewriteCreateStoreFunc = initState
        initState = nil
    end

    if rewriteCreateStoreFunc then
        local newCreateStore = rewriteCreateStoreFunc(createStore)
        return newCreateStore(reducer, initState)
    end

    local state = initState
    local listeners = {}
    local subscribe = function(listener)
        table.insert(listeners, listener)
        return function()
            for index, value in ipairs(listeners) do
                if listener == value then
                    return table.remove(listeners, index)
                end
            end
        end
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
    local replaceReducer = function(nextReducer)
        reducer = nextReducer
        dispatch({type = ''})
    end

    dispatch({type = ''})

    return {
        subscribe = subscribe,
        dispatch = dispatch,
        getState = getState,
        replaceReducer = replaceReducer,
    }
end

return createStore