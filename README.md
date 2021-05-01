
Minimal implementation for Roact-Rodux where the Server Store is pushed over to the Client. Solution uses two identical stores, Global Store and Client Store. Global Store uses a replicator middleware to send all the dispatch actions over to Client Store using a remote event. When Client Store is created it uses remote function to request current Global Store state.

All credits to always helpful Roblox OS Community Discord on Roact, Rodux channels. Thanks all!
