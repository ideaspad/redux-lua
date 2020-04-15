local createStore = require "redux/createStore"
local combineReducers = require "redux/combineReducers"
local applyMiddleware = require "redux/applyMiddleware"

local counterReducer = require "test/reducers/counterReducer"
local infoReducer = require "test/reducers/infoReducer"

local loggerMiddleware = require "test/middlewares/loggerMiddleware"
local exceptionMiddleware = require "test/middlewares/exceptionMiddleware"
local timeMiddleware = require "test/middlewares/timeMiddleware"

local reducer = combineReducers({counter = counterReducer, info = infoReducer})

local rewriteCreateStoreFunc = applyMiddleware(exceptionMiddleware, timeMiddleware, loggerMiddleware)

local store = createStore(reducer, nil, rewriteCreateStoreFunc)
store.subscribe(function()
    local state = store.getState()
    print(state.counter.count, state.info.name, state.info.description)
end)

store.dispatch({type = 'SET_NAME', name = "Rocky Wu"})