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
        value = value,
    }
end

local function setValueB(value)
    return {
        type = "SetValueB",
        value = value,
    }
end

print("Server : Setting A = 10, B = 20")
store.Store:dispatch(setValueA(10))
store.Store:dispatch(setValueA(20))

print("=================== Server Stop ===================")
