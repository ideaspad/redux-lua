local initState = {
    name = '',
    description = ''
}

local infoReducer = function(state, action)
    state = state or initState

    if action.type == 'SET_NAME' then
        state.name = action.name
    elseif action.type == 'SET_DESCRIPTION' then
        state.description = action.description
    end
    return state
end

return infoReducer