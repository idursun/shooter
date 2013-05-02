require "bullets"
require "player"
require "controller"
require "ai"
require "resources"

function love.load()
  resources = Resources.new()
  width, height = love.graphics.getMode()
  tile_size = 32
  resources:addImage("tiles", "tiles.png")
  resources:addImage("dot", "dot.png")
  tiles = {
      love.graphics.newQuad(tile_size*0,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(tile_size*1,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(tile_size*2,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(tile_size*3,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(0,tile_size*1, tile_size, tile_size, 128,128),
      love.graphics.newQuad(0,tile_size*2, tile_size, tile_size, 128,128),
      love.graphics.newQuad(tile_size,tile_size*2, tile_size, tile_size, 128,128)
  }
  sheet ={}
  for y=-1, height/tile_size do
      sheet[y] = {}
      for x=0, width/tile_size do
          sheet[y][x] = math.random(1,#tiles)
      end    
  end
  top = {x=0, y=0}

  resources:addFont("font_text", "font.ttf", 30)

  resources:load()

  bullets = BulletBatch.new(dotImg)
  player = Player.new(tileSheet)
  controller = Controller.new()
  ai = Ai.new()
end

function love.update(dt)
  controller:update(dt)
  player:update(dt)

  top.y = math.ceil(top.y + dt * 20)
  if top.y > tile_size then
    top.y = 0
    table.remove(sheet,31)
    table.insert(sheet,-1, {0})
    for x=0, width/tile_size do
      sheet[-1][x] = math.random(1,#tiles)
    end
  end
  bullets:update(dt)
  ai:update(dt)
  local toremove = {}
  for i, v in pairs(ai:get_enemies()) do
      if (bullets:is_hit(v.pos.x, v.pos.y)) then
          table.insert(toremove, i)
      end
  end

  for i=#toremove, 1, -1 do
      ai:remove(toremove[i])
  end
end

function love.draw()

  for y=-1, height/tile_size do
      for x=0, width/tile_size do
          love.graphics.drawq(resources.images.tiles, tiles[sheet[y][x]], x * tile_size, top.y + y * tile_size)
      end    
  end

  ai:draw()
  bullets:draw()
  player:draw()
  love.graphics.setBlendMode("multiplicative")
  love.graphics.setBlendMode("alpha")
  love.graphics.setFont(resources.fonts.font_text)
  love.graphics.print(controller:get_axis_x(),0,0)
  love.graphics.print(("bullets: %d"):format(bullets:count()) ,30,0)
  love.graphics.print("fps:"..love.timer.getFPS(), width - 200,0)
end
