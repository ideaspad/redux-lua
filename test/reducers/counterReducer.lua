local initState = {
    count = 0
}

local counterReducer = function(state, action)
    state = state or initState

    if action.type == 'INCREMENT' then
        state.count = state.count + 1
    elseif action.type == 'DECREMENT' then
        state.count = state.count - 1
    end
    return state
end

return counterReducer