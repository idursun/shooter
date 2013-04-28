require "bullets"

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
  ship_pos = {x = width/2, y = height - tile_size*2}
  top = {x=0, y=0}

  font_text = love.graphics.newFont("font.ttf",30)
  font_score = love.graphics.newImageFont("score_font.png", "0123456789")
end

function love.update(dt)
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

  ship_pos.x = (ship_pos.x + (axis_x * 128 * dt))
  ship_pos.y = (ship_pos.y + (axis_y * 128 * dt))

  if love.keyboard.isDown(" ") and gun_heat < 0 then 
    bullets:add({ship_pos.x + tile_size/2, ship_pos.y},     {   0, -392}, 0)
    bullets:add({ship_pos.x + tile_size/2 - 4, ship_pos.y}, {-128, -392}, 0)
    bullets:add({ship_pos.x + tile_size/2 + 4, ship_pos.y}, { 128, -392}, 0)
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

  love.graphics.drawq(tileSheet, shipq, math.ceil(ship_pos.x), math.ceil(ship_pos.y))
  bullets:draw()

  love.graphics.setBlendMode("multiplicative")
  love.graphics.drawq(tileSheet, ship_shadowq, ship_pos.x+32, ship_pos.y+32)
  love.graphics.setBlendMode("alpha")
  love.graphics.setFont(font_text)
  love.graphics.print(axis_x,0,0)
  love.graphics.print(("bullets: %d"):format(bullets:count()) ,30,0)
  love.graphics.setFont(font_score)
  love.graphics.print("102004", 10,10)
end
