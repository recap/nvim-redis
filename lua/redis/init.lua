-- Imports the plugin's additional Lua modules.
local fetch = require("redis.fetch")
local argparse = require("redis.argparse")

local function setup(parameters)
end
-- Creates an object for the module. All of the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`.
--local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules.

vim.api.nvim_create_user_command(
  'RedisListKeys',
  function(parameters)
    args = argparse.parse(parameters.fargs)
    if argparse.exists(args, 'host') then
      fetch.fetch_keys(args.host)
    elseif vim.g.redis_host ~= nil then
      fetch.fetch_keys(vim.g.redis_host)
    else
      print("missing host argument!")
    end
  end,
  {bang = false, desc = 'list redis keys', nargs='*'}
)

vim.api.nvim_create_user_command(
  'RedisHost',
  function(parameters)
    if (parameters.args ~= '') and (parameters.args ~= nil) then
      vim.g.redis_host = parameters.args
      print("set redis_host: "..vim.g.redis_host)
    else
      if (vim.g.redis_host ~= nil) then
        print("redis_host: "..vim.g.redis_host)
      end
    end
  end,
  {bang = false, desc = 'list redis keys', nargs='?'}
)

return {
  setup = setup
}

--return M
    
