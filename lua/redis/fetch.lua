-- Creates an object for the module.
local M = {}

local function is_empty(s)
  return ((s == '') or (s == nil))
end

local function get_output_as_string(data)
  output = ""
  for i, k in ipairs(data) do
    if (k ~= '') then
      output = output .. k .. ", "
    end
  end
  if (output ~= '') then
    output = output:sub(1, -3)
  end
  return output
end

local function handle_cmd_error(chanid, data, name)
  output = get_output_as_string(data)

  if is_empty(output) then
    return
  end

  print("Error executing cmd: "..command)
  print(output)
end


function M.fetch_keys()

  host = vim.g.redis_host
  port = vim.g.redis_host_port

  command = "redis-cli -h "..host.." -p "..port.." keys '*'"
  
  local jobid = vim.fn.jobstart(command,
      {
          on_stdout = function(chanid, data, name)
            output = get_output_as_string(data)
            if is_empty(output) then
              return
            end
            print("Keys: "..output)
          end,
          on_stderr = function(chanid, data, name)
            handle_cmd_error(chanid, data, name)
          end,
      }
  )
  vim.fn.jobwait({ jobid })

end

function M.get_key(key)
  if is_empty(key) then
    return
  end

  host = vim.g.redis_host
  port = vim.g.redis_host_port

  command = "redis-cli -h "..host.." -p "..port.." get "..key

  no_output = false
  
  local jobid = vim.fn.jobstart(command,
      {
          on_stdout = function(chanid, data, name)
            output = get_output_as_string(data)
            if is_empty(output) then
              return
            end
            print(key.." => "..output)
            no_output = true
          end,
          on_stderr = function(chanid, data, name)
            handle_cmd_error(chanid, data, name)
          end,
      }
  )
  vim.fn.jobwait({ jobid })
  if no_output == false then
    print("Key not found: "..key)
  end
end

function M.hget_key(key, field)
  if is_empty(key) or is_empty(field) then
    return
  end

  host = vim.g.redis_host
  port = vim.g.redis_host_port

  command = "redis-cli -h "..host.." -p "..port.." hget "..key.." "..field

  no_output = false
  
  local jobid = vim.fn.jobstart(command,
      {
          on_stdout = function(chanid, data, name)
            output = get_output_as_string(data)
            if is_empty(output) then
              return
            end
            print(key..","..field.." => "..output)
            no_output = true
          end,
          on_stderr = function(chanid, data, name)
            handle_cmd_error(chanid, data, name)
          end,
      }
  )
  vim.fn.jobwait({ jobid })
  if no_output == false then
    print("Hkey not found: "..key..","..field)
  end
end
return M
    
