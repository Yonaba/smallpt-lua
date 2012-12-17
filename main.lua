--[[
	Copyright (c) 2012 Roland Yonaba

	Permission is hereby granted, free of charge, to any person obtaining a
	copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be included
	in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

local im, progress, imData, mapData
local w, h, myScene, renderer
local time
local done = false
local GI = require 'renderer' 

function love.load() 

  -- Configuration 
  myScene = require 'scenes.cornellbox' -- Scene to be rendered
  width, height = 200, 100 -- Image (viewport) width, height
  aa, spp, depth = 2, 10, 2 -- Antialiasing (2+), samples per pixel (16+), max_depth (2~5)
  -- End of configuration
  
  renderer = GI:newRenderer(width, height, aa, spp, depth)
end


function love.update(dt)
  if not done then
    time = (time or 0) + dt
    local status, mapData = renderer:render(myScene)
    if status then
      imData = love.image.newImageData(width, height)
      for y = 0,height-1 do
        for x = 0,width-1 do
          imData:setPixel(x,y,mapData[y][x].x, mapData[y][x].y, mapData[y][x].z, 255)
        end
      end
      done = true
      im = love.graphics.newImage(imData)
    else 
      progress = mapData
    end
  end
end

function love.draw()
  if im then love.graphics.draw(im,0,0)
  else
    love.graphics.print(('Generating scene... Progress: %.2f %%'):format(progress),10,10)
  end
end