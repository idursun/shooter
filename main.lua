require "bullets"
require "player"
require "controller"
require "ai"
require "resources"
require "level"

function love.load()
  resources = Resources.new()
  width, height = love.graphics.getMode()
  resources:addImage("tiles", "tiles.png")
  resources:addImage("dot", "dot.png")
  resources:addFont("font_text", "font.ttf", 30)
  resources:load()

  bullets = BulletBatch.new(dotImg)
  player = Player.new(tileSheet)
  controller = Controller.new()
  ai = Ai.new()
  level = Level.new()
end

function love.update(dt)
  controller:update(dt)
  player:update(dt)
  ai:update(dt)
  bullets:update(dt)
  level:update(dt)
end

function love.draw()
  level:draw()
  player:draw()
  bullets:draw()
  ai:draw()
  love.graphics.setBlendMode("multiplicative")
  love.graphics.setBlendMode("alpha")
  love.graphics.setFont(resources.fonts.font_text)
  love.graphics.print(controller:get_axis_x(),0,0)
  love.graphics.print(("bullets: %d"):format(bullets:count()) ,30,0)
  love.graphics.print("fps:"..love.timer.getFPS(), width - 200,0)
end
