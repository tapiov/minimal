local Store = {}

local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local libs = replicatedStorage:WaitForChild("Libs")
local rodux = require(libs.Rodux)

-- Events
local events = replicatedStorage:WaitForChild("Events")

-- ============== valueA ==============
-- Reducer for the current valueA
local valueAReducer =
	rodux.createReducer(
	0,
	{
		SetValueA = function(state, action)
			return action.valueA
		end
	}
)

-- ============== valueB ==============
-- Reducer for the current valueB
local valueBReducer =
	rodux.createReducer(
	0,
	{
		SetValueB = function(state, action)
			return action.valueB
		end
	}
)

-- Combine A and B
local reducer = rodux.combineReducers({valueA = valueAReducer, valueB = valueBReducer})

if runService:IsServer() then

	local store

	if (true) then

		local replicatorMiddleware = function(nextDispatch, store)
				return function(action)
					events.ServerClientPersistence:FireAllClients(action)
					nextDispatch(action)
				end
		end
	
		store =
			rodux.Store.new(
			reducer,
			nil,
			{
				replicatorMiddleware,
				rodux.loggerMiddleware
			}
		)
	else
		store =
			rodux.Store.new(
			reducer,
			nil,
			{
				rodux.loggerMiddleware
			}
		)
	end

	Store.GlobalStore = store

	-- Provide the current Global Store state to client on request
	local function fetchServerStore()
		return store.getState()
	end

	events.RequestServerStore.OnServerInvoke = fetchServerStore
	
elseif runService:IsClient() then
	-- Get the current Global store state using RemoteFunction
	local currentGlobalStoreState = events.RequestServerStore:InvokeServer()

	-- The client Store is created with the current Global state
	local clientStore = rodux.Store.new(reducer, currentGlobalStoreState)
	Store.ClientStore = clientStore

	-- Listener for server dispatches
	events.ServerClientPersistence.OnClientEvent:Connect(
		function(data)
			clientStore:dispatch(data)
		end
	)
end

return {Store = Store}
