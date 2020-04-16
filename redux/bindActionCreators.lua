local function bindActionCreator(actionCreator, dispatch)
    return function(...)
        return dispatch(actionCreator(...))
    end
end


local function bindActionCreators(actionCreators, dispatch) 
    if type(actionCreators) == 'function' then
        return bindActionCreator(actionCreators, dispatch)
    end

    if type(actionCreators) ~= 'table' or actionCreators == nil then
        return
    end

    local boundActionCreators = {}
    for key, actionCreator in pairs(actionCreators) do
        if type(actionCreator) == 'function' then
            boundActionCreators[key] = bindActionCreator(actionCreator, dispatch)
        end
    end
    return boundActionCreators
end

return bindActionCreators