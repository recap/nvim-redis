-- Creates an object for the module.
local M = {}

-- Fetches todo tasks from the database and
-- prints the output.
function M.fetch_keys(params)
  host = 'localhost'
  if(params ~= '') and (params ~= nil) then
    host = params
  end

  command = "redis-cli -h "..host.." keys '*'"
  args = {}
  
  local jobid = vim.fn.jobstart(command,
      {
          on_stdout = function(chanid, data, name)
              output = ""
              for i, k in ipairs(data) do
                if (k ~= '') then
                  output = output .. k .. ", "
                end
              end
              if (output ~= '') then
                output = output:sub(1, -3)
                print("keys: "..output)
              end
          end,
          on_stderr = function(chanid, data, name)
            print("error: "..vim.inspect(data))
          end,
      }
  )
  vim.fn.jobwait({ jobid })

end

return M
    
