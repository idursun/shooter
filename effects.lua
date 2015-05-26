Effects = {}
local effects = {}
function Effects.newExplosion(size, posx, posy)
  local system = love.graphics.newParticleSystem(resources.images.fire, size)
  system:setPosition(posx, posy)
  system:setBufferSize(2000)
  system:setEmissionRate(10)
  system:setEmitterLifetime(0.15)
  system:setParticleLifetime(0.15)
  system:setRotation(math.rad(0), math.rad(0))
  system:setSpin(0, 0, 1)
  system:setColors(255,255,255,255, 22, 22, 22,0)
  system:setSizes(1, 1.5, 2)
  system:setSpeed(90,90)
  system:setLinearAcceleration(0,0)
  system:setEmissionRate(100)
  system:setDirection(math.rad(-90))
  system:setSpread(math.rad(360))
  return system
end

function Effects.update(dt)
  toremove = {}
  for i, effect in pairs(effects) do
    effect:update(dt)
    if (effect:getCount() == 0) then
        table.insert(toremove, i)
    end
  end
  for i = #toremove, 1, -1 do
    table.remove(effects, toremove[i])
  end
end

function Effects.add(effect)
  table.insert(effects, effect)
  effect:start()
end

function Effects.draw()
  for i, effect in pairs(effects) do
    love.graphics.draw(effect)
  end
end

return Effects
