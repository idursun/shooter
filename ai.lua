Ai = {}
Ai.__index = Ai

function Ai.new()
  return setmetatable({
      enemyq = love.graphics.newQuad(tile_size*2, tile_size, tile_size, tile_size, 128, 128),
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
  toremove = {}
  for i, v in pairs(self.enemies) do
    v.pos.y = v.pos.y + 100 * dt
    v.pos.x = v.pos.x + math.random(-100,100) * dt
    if (bullets.is_hit(v.pos.x, v.pos.y)) then
        table.insert(toremove, i)
    end
  end
  for i = #toremove, 1, -1 do
    self:remove(i)
  end

end

function Ai:draw()
  for i, v in pairs(self.enemies) do
      love.graphics.drawq(resources.images.tiles, self.enemyq, v.pos.x, v.pos.y)
      love.graphics.rectangle("line", v.pos.x, v.pos.y, tile_size, tile_size)
  end
end
