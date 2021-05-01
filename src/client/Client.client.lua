print("=================== Client Start ===================")

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- Roact, Rodux & Store
local libs = replicatedStorage:WaitForChild("Libs")
local Roact = require(libs:WaitForChild("Roact"))
local Rodux = require(libs:WaitForChild("Rodux"))
local RoactRodux = require(libs:WaitForChild("Roact-Rodux"))
local store = require(replicatedStorage:WaitForChild("Store"))

-- Write your component as if Rodux is not involved first.
-- This helps guide you to create a more focused interface.

local function MyComponent()
    -- Values from Rodux can be accessed just like regular props
    -- local value = props.value

    return Roact.createElement("ScreenGui", {}, {
        HelloWorld = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, 400, 0, 300),
            Text = "Hello, Roact!"
        })
    })
end


-- `connect` accepts two optional functions:
-- `mapStateToProps` accepts your store's state and returns props
-- `mapDispatchToProps` accepts a dispatch function and returns props

-- Both functions should return a table containing props that will be passed to
-- your component!

-- `connect` returns a function, so we call that function, passing in our
-- component, getting back a new component!
-- MyComponent = RoactRodux.connect(
--     function(state, props)
--         -- mapStateToProps is run every time the store's state updates.
--         -- It's also run whenever the component receives new props.
--         return {
--             value = state.value,
--         }
--     end
-- )(MyComponent)


-- local app = Roact.createElement(RoactRodux.StoreProvider, {
--     store = store.store,
-- }, {
--     Main = Roact.createElement(MyComponent),
-- })


local PlayerGui = players.LocalPlayer.PlayerGui

local handle = Roact.mount(MyComponent(), PlayerGui, "Minimal GUI")
