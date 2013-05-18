local BulletBatch = {}
local bullets = {}
local batch
BulletBatch.bullets = bullets

function BulletBatch.initialize()
  batch = love.graphics.newSpriteBatch(resources.images.dot)
end

function BulletBatch.add(position, direction, bullet_type)
    table.insert(bullets, {
        pos= position, 
        dir= direction, 
        bullet_type = bullet_type,
        will_remove = false
    }) 
end

function BulletBatch.is_hit(pos_x, pos_y)
  local half_tile_size = tile_size/2
  for i, v in pairs(bullets) do
    print(v.pos[1])
    print(pos_x)
    if (pos_x > v.pos[1] - half_tile_size 
    and pos_x < v.pos[1] + half_tile_size 
    and pos_y > v.pos[2] - half_tile_size 
    and pos_y < v.pos[2] + half_tile_size) then
      v.will_remove = true
      return true
    end
  end
end

function BulletBatch.update(dt)
  for i, bullet in pairs(bullets) do
      bullet.pos[1] = bullet.pos[1] + bullet.dir[1] * dt
      bullet.pos[2] = bullet.pos[2] + bullet.dir[2] * dt
      if bullet.pos[1] < 0 or bullet.pos[2] < 0 or bullet.pos[1] > width or bullet.pos[2] > height then
          bullet.will_remove = true
      end
  end

  for i = #bullets, 1, -1 do
    if bullets[i].will_remove then
       table.remove(bullets, i)
       i = i -1
    end
  end
  batch:bind()
  batch:clear()
  for i, bullet in pairs(bullets) do
    batch:add(bullet.pos[1], bullet.pos[2])
  end
  batch:unbind()
end

function BulletBatch.count()
  return #bullets
end

function BulletBatch.draw()
  love.graphics.draw(batch)
end

return BulletBatch
