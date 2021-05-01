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
        valueA = value
    }
end

local function setValueB(value)
    return {
        type = "SetValueB",
        valueB = value
    }
end

print("Server : A = " .. store.Store.GlobalStore:getState().valueA .. "  B = " .. store.Store.GlobalStore:getState().valueB)

for i = 1, 10, 1 do

    wait(5)

    print("Server : Setting A = A + 1")
    local newA = store.Store.GlobalStore:getState().valueA + 1
    store.Store.GlobalStore:dispatch(setValueA(newA))
    
    print("Server : Setting B = B + 2")
    local newB = store.Store.GlobalStore:getState().valueB + 2
    store.Store.GlobalStore:dispatch(setValueB(newB))
    
    print("Server : A = " .. store.Store.GlobalStore:getState().valueA .. "  B = " .. store.Store.GlobalStore:getState().valueB)
        
end

print("=================== Server Stop ===================")
