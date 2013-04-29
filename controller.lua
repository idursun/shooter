Controller = {}
Controller.__index = Controller

function Controller.new()
  return setmetatable({axis_x = 0, axis_y = 0}, Controller)
end

function Controller:update(dt)
  local accelaration = 0.5
  local deccelaration = 0.1

  if self.axis_x ~= 0 then 
    self.axis_x = self.axis_x + (self.axis_x < 0 and deccelaration or -deccelaration)
    if math.abs(self.axis_x) < 0.1 then self.axis_x = 0 end
  end

  if self.axis_y ~= 0 then 
    self.axis_y = self.axis_y + (self.axis_y < 0 and deccelaration or -deccelaration)
    if math.abs(self.axis_y) < 0.1 then self.axis_y = 0 end
  end

  if love.keyboard.isDown("up") then 
      self.axis_y = math.max(self.axis_y - accelaration, -1)
  end

  if love.keyboard.isDown("down") then 
      self.axis_y = math.min(self.axis_y + accelaration, 1)
  end

  if love.keyboard.isDown("left") then 
      self.axis_x = math.max(self.axis_x - accelaration, -1)
  end

  if love.keyboard.isDown("right") then 
      self.axis_x = math.min(self.axis_x + accelaration, 1)
  end

end

function Controller:get_axis_x()
  return self.axis_x
end

function Controller:get_axis_y()
  return self.axis_y
end

function Controller:draw()
end
