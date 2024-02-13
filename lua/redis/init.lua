-- Imports the plugin's additional Lua modules.
local fetch = require("redis.fetch")

local function setup(parameters)
end
-- Creates an object for the module. All of the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`.
--local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules.
--M.fetch_keys = fetch.fetch_keys
vim.api.nvim_create_user_command(
  'ListKeys',
  function(parameters)
    print(vim.inspect(parameters))
    print(parameters.fargs[1])
    print(parameters.fargs[2])
    fetch.fetch_keys(parameters.args)
  end,
  {bang = false, desc = 'list redis keys', nargs='*'}
)

return {
  setup = setup
}

--return M
    
