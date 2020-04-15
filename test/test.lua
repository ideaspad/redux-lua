local createStore = require "redux/createStore"
local combineReducers = require "redux/combineReducers"

local counterReducer = require "test/reducers/counterReducer"
local infoReducer = require "test/reducers/infoReducer"

local exceptionMiddleware = require "test/middlewares/exceptionMiddleware"
local loggerMiddleware = require "test/middlewares/loggerMiddleware"
local timeMiddleware = require "test/middlewares/timeMiddleware"

local reducer = combineReducers({counter = counterReducer, info = infoReducer})

local store = createStore(reducer)
store.subscribe(function()
    local state = store.getState()
    print(state.counter.count, state.info.name, state.info.description)
end)

local next = store.dispatch
local logger = loggerMiddleware(store)
local exception = exceptionMiddleware(store)
local time = timeMiddleware(store)
store.dispatch = time(exception(logger(next)))

store.dispatch({type = 'SET_NAME', name = "Rocky Wu"})