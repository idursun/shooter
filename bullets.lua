BulletBatch = {}

BulletBatch.__index = BulletBatch
function BulletBatch.new(image)
  return setmetatable({
      image = image, 
      bullets={}
  }, BulletBatch)
end

function BulletBatch:add(position, direction, bullet_type)
    table.insert(self.bullets, {pos= position, dir= direction, bullet_type = bullet_type}) 
end

function BulletBatch:update(dt)
  local toremove= {}
  for i, bullet in pairs(self.bullets) do
      bullet.pos[1] = bullet.pos[1] + bullet.dir[1] * dt
      bullet.pos[2] = bullet.pos[2] + bullet.dir[2] * dt
      if bullet.pos[1] < 0 or bullet.pos[2] < 0 or bullet.pos[1] > 2000 or bullet.pos[2] > 2000 then
          table.insert(toremove, i)
      end
  end

  for i = #toremove, 1, -1 do
    table.remove(self.bullets, toremove[i])
  end
end

function BulletBatch:count()
  return #self.bullets
end

function BulletBatch:draw()
  for i, bullet in pairs(self.bullets) do
    love.graphics.draw(self.image, bullet.pos[1], bullet.pos[2])
  end
end
