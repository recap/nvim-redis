-- Creates an object for the module.
local M = {}

-- Fetches todo tasks from the database and
-- prints the output.
function M.fetch_keys()
  command = "redis-cli -h 172.17.0.3 keys '*'"
  args = {}
  
  local jobid = vim.fn.jobstart(command,
      {
          on_stdout = function(chanid, data, name)
              for i, k in ipairs(data) do
                print (k)
              end

              --print("keys: " .. vim.inspect(data))
          end,
          -- on_stderr = function(chanid, data, name)
          --     print("stderr, data:" .. vim.inspect(data))
          -- end,
          -- on_exit = function(id, exitcode, event)
          --     print("exit, exitcode:" .. vim.inspect(exitcode))
          -- end,
      }
  )
  vim.fn.jobwait({ jobid })

end

return M
    
