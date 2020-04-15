local createStore = require "redux/createStore"
local combineReducers = require "redux/combineReducers"

local counterReducer = require "test/reducers/counterReducer"
local infoReducer = require "test/reducers/infoReducer"


local reducer = combineReducers({counter = counterReducer, info = infoReducer})

local store = createStore(reducer)
store.subscribe(function()
    local state = store.getState()
    print(state.counter.count, state.info.name, state.info.description)
end)

store.dispatch({type = 'INCREMENT'})
store.dispatch({type = 'INCREMENT'})
store.dispatch({type = 'INCREMENT'})
store.dispatch({type = 'SET_NAME', name = "Rocky Wu"})