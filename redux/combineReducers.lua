local combineReducers = function(reducers)
    local combination = function(state, action)
        state = state or {}
        local nextState = {}
        for key, reducer in pairs(reducers) do
            local previousStateForKey = state[key]
            local nextStateForKey = reducer(previousStateForKey, action)
            nextState[key] = nextStateForKey
        end
        return nextState
    end
    return combination
end

return combineReducers