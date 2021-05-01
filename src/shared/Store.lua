local Store = {}

local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local libs = replicatedStorage:WaitForChild("Libraries") 
local rodux = require(libs.Rodux)

-- Events
local events = replicatedStorage:WaitForChild("Events")

local initialServerState = { valueA = 0, valueB = 0 }
local initialClientState = { valueA = 0, valueB = 0 }

-- ============== valueA ==============
-- Reducer for the current valueA
local valueAReducer = rodux.createReducer(200, {
    SetValueA = function(state, action)
        return action.valueA
    end
})

-- ============== valueB ==============
-- Reducer for the current valueB
local valueBReducer = rodux.createReducer(200, {
    SetValueB = function(state, action)
        return action.valueB
    end
})


local reducer = rodux.combineReducers({
    valueA = valueAReducer,
    valueB = valueBReducer
})

if runService:IsServer() then 
    local replicatorMiddleware = function(store)
        return function(nextDispatch)
            return function(action)
                events.ServerClientPersistence:FireAllClients(action)
                nextDispatch(action)
            end
        end
    end

    local store = rodux.Store.new(reducer, initialServerState, {
        replicatorMiddleware, rodux.loggerMiddleware,
    })

    Store.GlobalStore = store
    
    local function fetchServerStore() 
        return store.getState()
    end

    events.RequestServerStore.onServerInvoke = fetchServerStore()

elseif runService:IsClient() then

    local store = rodux.Store.new(function(action, currentState) 
        local state = currentState
    end)

    local clientStore = rodux.Store.new(reducer, initialClientState)

    Store.ClientStore = clientStore
    Store.GlobalStore = store

    events.ServerClientPersistence.onClientInvoke:Connect(function(data)
        store:dispatch(data)
    end)
end

return { Store = Store }
