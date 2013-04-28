require "bullets"
require "player"

function love.load()
  axis_x = 0
  axis_y = 0
  tile_size = 32
  gun_heat = 0
  tileSheet = love.graphics.newImage("tiles.png")
  dotImg = love.graphics.newImage("dot.png")
  bullets = BulletBatch.new(dotImg)
  tiles = {
      love.graphics.newQuad(tile_size*0,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(tile_size*1,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(tile_size*2,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(tile_size*3,0, tile_size, tile_size, 128,128),
      love.graphics.newQuad(0,tile_size*1, tile_size, tile_size, 128,128),
      love.graphics.newQuad(0,tile_size*2, tile_size, tile_size, 128,128)
  }
  shipq = love.graphics.newQuad(tile_size,tile_size,tile_size,tile_size, 128, 128)
  ship_shadowq = love.graphics.newQuad(tile_size*2,tile_size*2,tile_size,tile_size, 128, 128)
  width, height = love.graphics.getMode()
  sheet ={}
  for y=-1, height/tile_size do
      sheet[y] = {}
      for x=0, width/tile_size do
          sheet[y][x] = math.random(1,#tiles)
      end    
  end
  top = {x=0, y=0}

  font_text = love.graphics.newFont("font.ttf",30)
  font_score = love.graphics.newImageFont("score_font.png", "0123456789")
  player = Player.new(tileSheet, shipq, ship_shadowq)
end

function love.update(dt)
  player:update(dt)

  top.y = math.ceil(top.y + dt * tile_size)
  if top.y > tile_size then
    top.y = 0
    table.remove(sheet,31)
    table.insert(sheet,-1, {0})
    for x=0, width/tile_size do
      sheet[-1][x] = math.random(1,#tiles)
    end
  end
  bullets:update(dt)
end

function love.draw()
  for y=-1, height/tile_size do
      for x=0, width/tile_size do
          love.graphics.drawq(tileSheet, tiles[sheet[y][x]], x * tile_size, top.y + y * tile_size)
      end    
  end

  player:draw()
  bullets:draw()

  love.graphics.setBlendMode("multiplicative")
  love.graphics.setBlendMode("alpha")
  love.graphics.setFont(font_text)
  love.graphics.print(axis_x,0,0)
  love.graphics.print(("bullets: %d"):format(bullets:count()) ,30,0)
  love.graphics.setFont(font_score)
  love.graphics.print("102004", 10,10)
end
