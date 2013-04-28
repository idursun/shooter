BulletBatch = {}

BulletBatch.__index = BulletBatch
local bullets = {}
function BulletBatch.new()
  ret = {}
  setmetatable(ret, BulletBatch)
  return ret
end

function BulletBatch:add(pos, dir, typ)
    table.insert(bullets, {pos= pos, direction = dir, bullet_type = typ}) 
end

function BulletBatch:update(dt)
  local toremove= {}
  for i, bullet in pairs(bullets) do
      local dx = (bullet.direction[1] ) * dt
      local dy = (bullet.direction[2] ) * dt
      bullet.pos[1] = bullet.pos[1] + dx
      bullet.pos[2] = bullet.pos[2] + dy
      if bullet.pos[1] < 0 or bullet.pos[2] < 0 or bullet.pos[1] > 2000 or bullet.pos[2] > 2000 then
          table.insert(toremove, i)
      end
  end

  for i = #toremove, 1, -1 do
    table.remove(bullets, toremove[i])
  end
end

function BulletBatch:get_pos()
  return bullets
end
