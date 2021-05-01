

We need two identical store, Global Store and Client Store. Global Store uses a middleware to send all the dispatch actions over to Client Store. When Client Store is created it uses remote function to request current Global Store state.

Current state :

Trying to get the Global Store work first. However, the other value, B, gets removed  from store state and the state is not updated with dispatch

Log: 
13:02:04.471  =================== Server Start ===================  -  Server - Server:1
  13:02:04.476  >>>>   -  Server - Store:50
  13:02:04.476   ▶ {...}  -  Server - Store:51
  13:02:04.476   ▼  {
                    ["valueA"] = 0,
                    ["valueB"] = 0
                 }  -  Server - Server:28
  13:02:04.477  Server : A = 0  B = 0  -  Server - Server:29
  13:02:04.477  Server : Setting A = 10, B = 20  -  Server - Server:31
  13:02:04.477   ▼  {
                    ["valueA"] = 0
                 }  -  Server - Server:35
  13:02:04.477  =================== Server Stop ===================  -  Server - Server:38
  