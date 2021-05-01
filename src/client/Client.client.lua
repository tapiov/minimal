print("Hello world, from client!")


local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- Roact, Rodux & Store
local libs = replicatedStorage:WaitForChild("Common")
local Roact = require(libs:WaitForChild("Roact"))
local Rodux = require(libs:WaitForChild("Rodux"))
local RoactRodux = require(libs:WaitForChild("Roact-Rodux"))
local store = require(libs:WaitForChild("Store"))

-- Write your component as if Rodux is not involved first.
-- This helps guide you to create a more focused interface.

local function MyComponent(props)
    -- Values from Rodux can be accessed just like regular props
    local value = props.value
    local onClick = props.onClick

    return Roact.createElement("ScreenGui", nil, {
        Label = Roact.createElement("TextButton", {
            -- ...and used in your components!
            Text = "Current value: " .. value,
            Size = UDim2.new(1, 0, 1, 0),

            [Roact.Event.Activated] = onClick,
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
MyComponent = RoactRodux.connect(
    function(state, props)
        -- mapStateToProps is run every time the store's state updates.
        -- It's also run whenever the component receives new props.
        return {
            value = state.value,
        }
    end,
    function(dispatch)
        -- mapDispatchToProps only runs once, so create functions here!
        return {
            onClick = function()
                dispatch({
                    type = "increment",
                })
            end,
        }
    end
)(MyComponent)


local app = Roact.createElement(RoactRodux.StoreProvider, {
    store = store.store,
}, {
    Main = Roact.createElement(MyComponent),
})


local PlayerGui = players.LocalPlayer.PlayerGui

local handle = Roact.mount(app, PlayerGui, "Clock UI")
