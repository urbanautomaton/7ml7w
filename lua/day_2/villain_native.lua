Villain = { health = 100 }

function Villain:new(name)
  local obj = {
    name = name,
    health = self.health
  }

  setmetatable(obj, self)
  self.__index = self

  return obj
end

function Villain:take_hit()
  self.health = self.health - 10
end

SuperVillain = Villain:new()

function SuperVillain:take_hit()
  self.health = self.health - 5
end
