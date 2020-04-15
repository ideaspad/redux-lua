local createStore = require "redux/createStore"
local combineReducers = require "redux/combineReducers"
local applyMiddleware = require "redux/applyMiddleware"
local bindActionCreators = require "redux/bindActionCreators"

local counterReducer = require "test/reducers/counterReducer"
local infoReducer = require "test/reducers/infoReducer"

local loggerMiddleware = require "test/middlewares/loggerMiddleware"
local exceptionMiddleware = require "test/middlewares/exceptionMiddleware"
local timeMiddleware = require "test/middlewares/timeMiddleware"

local reducer = combineReducers({info = infoReducer})
local rewriteCreateStoreFunc = applyMiddleware(loggerMiddleware, exceptionMiddleware, timeMiddleware)
local store = createStore(reducer, rewriteCreateStoreFunc)
local nextReducer = combineReducers({counter = counterReducer, info = infoReducer})
store.replaceReducer(nextReducer)

local unsubscribe = store.subscribe(function()
    local state = store.getState()
    print(state.counter.count, state.info.name, state.info.description)
end)
-- unsubscribe()
-- store.dispatch({type = 'SET_NAME', name = "Rocky Wu"})

function increment()
    return {
      type = 'INCREMENT'
    }
end

function setName(name)
    return {
      type = 'SET_NAME',
      name = name
    }
end

local actions = bindActionCreators({increment = increment, setName = setName}, store.dispatch)
actions.increment()
actions.setName("Rocky Wu")
