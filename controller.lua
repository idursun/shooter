Controller = {}
Controller.__index = Controller

function Controller.new()
  return setmetatable({axis_x = 0, axis_y = 0}, Controller)
end

function Controller:update(dt)
  local accelaration = 0.5
  local shifted_y = false
  local shifted_x = false

  if love.keyboard.isDown("up") then 
      self.axis_y = math.max(self.axis_y - accelaration, -1)
      shifted_y = true
  end

  if love.keyboard.isDown("down") then 
      self.axis_y = math.min(self.axis_y + accelaration, 1)
      shifted_y = true
  end

  if love.keyboard.isDown("left") then 
      self.axis_x = math.max(self.axis_x - accelaration, -1)
      shifted_x = true
  end

  if love.keyboard.isDown("right") then 
      self.axis_x = math.min(self.axis_x + accelaration, 1)
      shifted_x = true
  end

  if not shifted_y then self.axis_y = 0 end
  if not shifted_x then self.axis_x = 0 end

end

function Controller:get_axis_x()
  return self.axis_x
end

function Controller:get_axis_y()
  return self.axis_y
end

function Controller:draw()
end
