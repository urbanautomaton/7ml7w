local function fibonacci()
  local m = 1
  local n = 1

  while true do
    coroutine.yield(m)
    m, n = n, m + n
  end
end

return fibonacci
