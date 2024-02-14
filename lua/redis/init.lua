-- Imports the plugin's additional Lua modules.
local fetch = require("redis.fetch")
local argparse = require("redis.argparse")

-- Set defaults. 
local function setup(parameters)
  vim.g.redis_host = 'localhost'
  vim.g.redis_host_port = 6379
  vim.g.redis_password = ""
  vim.g.redis_user = ""
  vim.g.redis_db = 0
end

local function is_empty(s)
  return ((s == '') or (s == nil))
end

-- Routes calls made to this module to functions in the
-- plugin's other modules.

-- List all redis keys
vim.api.nvim_create_user_command(
  'RListKeys',
  function(parameters)
    pattern = ""
    if is_empty(parameters.args) then
      pattern = "'*'"
    else
      pattern = parameters.args
    end
    fetch.fetch_keys(pattern)
  end,
  {bang = false, desc = 'list redis keys', nargs='?'}
)

-- Get a redis key value
vim.api.nvim_create_user_command(
  'RGetKey',
  function(parameters)
    if is_empty(parameters.args) then
      return
    end
    fetch.get_key(parameters.args)
  end,
  {bang = false, desc = 'get redis key value', nargs='?'}
)

-- Get a redis key value
vim.api.nvim_create_user_command(
  'RHGetKey',
  function(parameters)
    --print(vim.inspect(parameters))
    if #parameters.fargs ~= 2 then
      print("Wrong no of params!")
      return
    end
    key = parameters.fargs[1]
    field = parameters.fargs[2]
    fetch.hget_key(key, field)
  end,
  {bang = false, desc = 'get redis key value', nargs='*'}
)

-- Set redis parameters e.g. host, port, password and user
vim.api.nvim_create_user_command(
  'RSetParams',
  function(parameters)

    args = argparse.parse(parameters.fargs)
    if argparse.exists(args, 'host') then
      vim.g.redis_host = args.host
    end
    if argparse.exists(args, 'port') then
      vim.g.redis_host_port = args.port
    end
    if argparse.exists(args, 'pass') then
      vim.g.redis_password = args.pass
    end
    if argparse.exists(args, 'user') then
      vim.g.redis_user = args.user
    end
    if argparse.exists(args, 'db') then
      vim.g.redis_db = args.db
    end
  end,
  {bang = false, desc = 'list redis keys', nargs='*'}
)

return {
  setup = setup
}
