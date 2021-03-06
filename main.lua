require "resources"
bullets = require "bullets"
require "player"
require "controller"
require "ai"
require "level"
effects = require "effects"

function love.load()
  width, height = love.window.getMode()
  resources = Resources.new()
  resources:addImage("tiles", "resources/tiles.png")
  resources:addImage("fire", "resources/fire.png")
  resources:addImage("dot", "resources/dot.png")
  resources:addFont("font_text", "resources/font.ttf", 30)
  resources:load()

  player = Player.new()
  controller = Controller.new()
  ai = Ai.new()
  level = Level.new()
  bullets.initialize()
end

function love.update(dt)
  controller:update(dt)
  player:update(dt)
  ai:update(dt)
  bullets.update(dt)
  level:update(dt)
  effects.update(dt)
end

function love.draw()
  level:draw()
  player:draw()
  bullets.draw()
  ai:draw()
  effects.draw()
  love.graphics.setBlendMode("multiplicative")
  love.graphics.setBlendMode("alpha")
  love.graphics.setFont(resources.fonts.font_text)
  love.graphics.print(controller:get_axis_x(),0,0)
  love.graphics.print(("bullets: %d"):format(bullets.count()) ,30,0)
  love.graphics.print("fps:"..love.timer.getFPS(), width - 200,0)
end
