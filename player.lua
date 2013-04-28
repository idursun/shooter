Player = {}
Player.__index = Player

function Player.new(image, shipq, ship_shadowq)
   return setmetatable({
        image = image,
        shipq = shipq,
        ship_shadowq = ship_shadowq,
        gun_heat = 0,
        ship_pos = {x = width/2, y = height - tile_size*2}
   }, Player)
end

function Player:update(dt)
  local shift_x = false
  local shift_y = false
  local accelaration = 0.5
  local deccelaration = 0.5
  if love.keyboard.isDown("up") then 
      axis_y = math.max(axis_y - accelaration, -1)
      shift_y = true
  end
  if love.keyboard.isDown("down") then 
      axis_y = math.min(axis_y + accelaration, 1)
      shift_y = true
  end
  if love.keyboard.isDown("left") then 
      axis_x = math.max(axis_x - accelaration, -1)
      shift_x = true
  end
  if love.keyboard.isDown("right") then 
      axis_x = math.min(axis_x + accelaration, 1)
      shift_x = true
  end

  self.ship_pos.x = (self.ship_pos.x + (axis_x * 128 * dt))
  self.ship_pos.y = (self.ship_pos.y + (axis_y * 128 * dt))

  if love.keyboard.isDown(" ") and gun_heat < 0 then 
    bullets:add({self.ship_pos.x + tile_size/2, self.ship_pos.y},     {   0, -392}, 0)
    bullets:add({self.ship_pos.x + tile_size/2 - 4, self.ship_pos.y}, {-128, -392}, 0)
    bullets:add({self.ship_pos.x + tile_size/2 + 4, self.ship_pos.y}, { 128, -392}, 0)
    gun_heat = 2
  end

  gun_heat = gun_heat - 0.5
  if not shift_x and axis_x ~= 0 then 
    axis_x = axis_x + (axis_x < 0 and deccelaration or -deccelaration)
    if math.abs(axis_x) < 0.1 then axis_x = 0 end
  end

  if not shift_y and axis_y ~= 0 then 
    axis_y = axis_y + (axis_y < 0 and deccelaration or -deccelaration)
    if math.abs(axis_y) < 0.1 then axis_y = 0 end
  end
end

function Player:draw()
  love.graphics.drawq(self.image, self.shipq, math.ceil(self.ship_pos.x), math.ceil(self.ship_pos.y))
  love.graphics.drawq(self.image, self.ship_shadowq, self.ship_pos.x+32, self.ship_pos.y+32)
end
