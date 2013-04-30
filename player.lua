require "resources"

Player = {}
Player.__index = Player

function Player.new()
  local shipq = love.graphics.newQuad(tile_size,tile_size,tile_size,tile_size, 128, 128)
  local ship_shadowq = love.graphics.newQuad(tile_size*2,tile_size*2,tile_size,tile_size, 128, 128)
  local sx, sy, w, h = shipq:getViewport()
   return setmetatable({
        shipq = shipq,
        ship_shadowq = ship_shadowq,
        size = { width = w, height = h},
        gun_heat = 0,
        ship_pos = {x = width/2, y = height - tile_size*2}
   }, Player)
end

function Player:update(dt)
  local axis_x = controller:get_axis_x()
  local axis_y = controller:get_axis_y()
  self.ship_pos.x = (self.ship_pos.x + (axis_x * 400 * dt))
  self.ship_pos.y = (self.ship_pos.y + (axis_y * 300 * dt))

  if self.ship_pos.x < 0 then self.ship_pos.x = 0 end
  if self.ship_pos.x > width-self.size.width then self.ship_pos.x = width-self.size.width end
  if self.ship_pos.y > height-self.size.height then self.ship_pos.y = height-self.size.height end
  if self.ship_pos.y < 0 then self.ship_pos.y = 0 end

  if love.keyboard.isDown(" ") and self.gun_heat < 0 then 
    bullets:add({self.ship_pos.x + tile_size/2, self.ship_pos.y},     {   0, -392}, 0)
    bullets:add({self.ship_pos.x + tile_size/2 - 4, self.ship_pos.y}, {-128, -392}, 0)
    bullets:add({self.ship_pos.x + tile_size/2 + 4, self.ship_pos.y}, { 128, -392}, 0)
    self.gun_heat = 2
  end

  self.gun_heat = self.gun_heat - 0.5
end

function Player:draw()
  love.graphics.drawq(resources.images.tiles, self.shipq, math.ceil(self.ship_pos.x), math.ceil(self.ship_pos.y))
  love.graphics.drawq(resources.images.tiles, self.ship_shadowq, math.ceil(self.ship_pos.x+32), math.ceil(self.ship_pos.y+32))
end
