
local M = {}

function M.parse(fargs)
  t = {}
  pos = ""
  i = 0
  while i <= #fargs do
    i = i + 1
    arg = fargs[i]
    if (arg ~= '') and (arg ~= nil) then
      if (string.sub(arg, 1,1) == "-") then
        pos = ""
        k = string.sub(arg, 2)
        t[k] = fargs[i+1]
        i = i + 1
      else
        pos = pos.." "..arg
      end
    end
  end
  t["positional"] = string.sub(pos, 2)
  return t
end

function M.exists(args, key)
  return (args[key] ~= nil)
end

return M
