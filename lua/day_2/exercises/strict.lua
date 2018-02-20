local _private = {}

function strict_read(table, key)
  if _private[key] then
    return _private[key]
  else
    error('Unknown key: ' .. key)
  end
end

function strict_write(table, key, value)
  if value ~= nil and _private[key] then
    error('Duplicate key: ' .. key)
  elseif value == nil and not _private[key] then
    error('Unknown key: ' .. key)
  else
    _private[key] = value
  end
end

local mt = {
  __index = strict_read,
  __newindex = strict_write
}

treasure = {}
setmetatable(treasure, mt)
