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
  local axis_x = controller:get_axis_x()
  local axis_y = controller:get_axis_y()
  self.ship_pos.x = (self.ship_pos.x + (axis_x * 512 * dt))
  self.ship_pos.y = (self.ship_pos.y + (axis_y * 512 * dt))

  if love.keyboard.isDown(" ") and self.gun_heat < 0 then 
    bullets:add({self.ship_pos.x + tile_size/2, self.ship_pos.y},     {   0, -392}, 0)
    bullets:add({self.ship_pos.x + tile_size/2 - 4, self.ship_pos.y}, {-128, -392}, 0)
    bullets:add({self.ship_pos.x + tile_size/2 + 4, self.ship_pos.y}, { 128, -392}, 0)
    self.gun_heat = 2
  end

  self.gun_heat = self.gun_heat - 0.5
end

function Player:draw()
  love.graphics.drawq(self.image, self.shipq, math.ceil(self.ship_pos.x), math.ceil(self.ship_pos.y))
  love.graphics.drawq(self.image, self.ship_shadowq, math.ceil(self.ship_pos.x+32), math.ceil(self.ship_pos.y+32))
end
