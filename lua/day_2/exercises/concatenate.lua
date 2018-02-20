local function concatenate(a1, a2)
  local result = {table.unpack(a1)}

  for _, v in pairs(a2) do
    table.insert(result, v)
  end

  return result
end

setmetatable(_G, {
  __newindex = function(array, index, value)
    rawset(array, index, value)
    if type(value) == 'table' then
      setmetatable(value, {
        __add = concatenate
      })
    end
  end
})

return concatenate
