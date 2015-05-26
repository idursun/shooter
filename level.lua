Level = {}
Level.__index = Level

local w, h = love.window.getMode()
tile_size = 32

function Level.new()
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
  for y=-1, h/tile_size do
      sheet[y] = {}
      for x=0, w/tile_size do
          sheet[y][x] = math.random(1,#tiles)
      end    
  end
  top = {x=0, y=0}
    return setmetatable({
        tiles= tiles,
        sheet=sheet,
    },Level)
end

function Level:update(dt)
  top.y = math.ceil(top.y + dt * 20)
  if top.y > tile_size then
    top.y = 0
    table.remove(sheet,31)
    table.insert(sheet,-1, {0})
    for x=0, w/tile_size do
      sheet[-1][x] = math.random(1,#tiles)
    end
  end
end

function Level:draw()
  for y=-1, h/tile_size do
      for x=0, w/tile_size do
          love.graphics.draw(resources.images.tiles, tiles[sheet[y][x]], x * tile_size, top.y + y * tile_size)
      end    
  end
end
