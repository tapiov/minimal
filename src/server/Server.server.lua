print("=================== Server Start ===================")

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- Roact, Rodux & Store
local libs = replicatedStorage:WaitForChild("Libs")
local Roact = require(libs:WaitForChild("Roact"))
local Rodux = require(libs:WaitForChild("Rodux"))
local RoactRodux = require(libs:WaitForChild("Roact-Rodux"))
local store = require(replicatedStorage:WaitForChild("Store"))

-- Store actions
local function setValueA(value)
    return {
        type = "SetValueA",
        value = value
    }
end

local function setValueB(value)
    return {
        type = "SetValueB",
        value = value
    }
end

print(store.Store.GlobalStore:getState())
print("Server : A = " .. store.Store.GlobalStore:getState().valueA .. "  B = " .. store.Store.GlobalStore:getState().valueB)

print("Server : Setting A = 10, B = 20")
store.Store.GlobalStore:dispatch(setValueA(10))
store.Store.GlobalStore:dispatch(setValueB(20))

print(store.Store.GlobalStore:getState())
-- print("Server : A = " .. store.Store.GlobalStore:getState().valueA .. "  B = " .. store.Store.GlobalStore:getState().valueB)

print("=================== Server Stop ===================")
