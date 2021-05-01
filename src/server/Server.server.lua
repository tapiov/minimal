print("Hello world, from server!")


local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- Roact, Rodux & Store
local libs = replicatedStorage:WaitForChild("Common")
local Roact = require(libs:WaitForChild("Roact"))
local Rodux = require(libs:WaitForChild("Rodux"))
local RoactRodux = require(libs:WaitForChild("Roact-Rodux"))
local store = require(libs:WaitForChild("Store"))

-- Store actions
local function storeOp()
    return {
        type = "SetTimeLeft",
        timeLeft = time,
    }
end

