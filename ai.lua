Ai = {}
Ai.__index = Ai

function Ai.new()
  return setmetatable({
      last_enemy_time = 0,
      enemies = {}
  }, Ai)
end

function Ai:get_enemies()
  return self.enemies
end

function Ai:remove(index)
  table.remove(self.enemies, index)
end

function Ai:update(dt)
  if self.last_enemy_time < 0 then 
    table.insert(self.enemies, {
        pos = {x = math.random(width), y = -100}
    })
    self.last_enemy_time = 1
  end
  self.last_enemy_time = self.last_enemy_time - dt
  for i, v in pairs(self.enemies) do
    v.pos.y = v.pos.y + 100 * dt
    v.pos.x = v.pos.x + math.random(-100,100) * dt
  end
end

function Ai:draw()
  for i, v in pairs(self.enemies) do
      love.graphics.drawq(tileSheet, enemyq, v.pos.x, v.pos.y)
  end
end
