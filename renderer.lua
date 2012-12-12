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

if (...) then

  local _BASE = (...):match('(.*)renderer$')
  local assertf = require (_BASE .. ('core.assert'))
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Ray = require (_BASE .. ('core.ray'))
  local radiance = require (_BASE .. ('core.radiance'))


  local rand, sqrt, pow, floor = math.random, math.sqrt, math.pow, math.floor
  local cos, tau = math.cos, 2 * math.pi
  local coroutine = coroutine

  -- Returns a 2D array w * h sized
  -- Indicing starts at 0 on width and height
  local array2d = function (w, h)
    local m = {}
    for y = 0, h-1 do m[y] = {}
      for i = 0, w-1 do m[y][i] = Vec3() end
    end
    return m
  end

  -- Maps f(...) on a given 2D array
  local mapfunc = function(map, f, ...)
    for y = 0, #map-1 do
      for x = 0, #map[y]-1 do
        map[y][x].x = f(map[y][x].x, ...)
        map[y][x].y = f(map[y][x].y, ...)
        map[y][x].z = f(map[y][x].z, ...)
      end
    end
    return map
  end

  -- Applies Gamma correction/tone on a given value
  local mapGamma = function(x, factor, range)
    return floor(pow(x,1/factor) * range + 0.5)
  end

  -- Main rendering loop
  -- Not to be used straight, needs to be wrapped inside a coroutine
  -- ToDo: Refactor with a table-less vector class (for speed ?)
  local function render(scene, w, h, aa, spp, max_depth, eye, gaze, fov)
    local npix = h*w+h+w
    local inv_aa_sq = 1/(aa * aa)
    local cos_fov = cos(fov)
    local cam = Ray(eye, gaze)
    local cx = Vec3(w * cos_fov / h) -- X-axis cam increment
    local cy = ((cx % (cam.direction)):norm()) * cos_fov -- Y-axis cam increment
    local map = array2d(w,h)
    local gammaFactor, colorRange = 2.2, 255
    
    for y = 0, h-1 do
      for x = 0, w-1 do
      
        for sy = 0, aa-1 do
          for sx = 0, aa-1 do
            local r = Vec3()
            for s = 1, spp do
              local r1 , r2 = 2 * rand(), 2 * rand()  -- random seeds for tent filtering
              local dx = r1 < 1 and sqrt(r1) - 1 or 1 - sqrt(2 - r1)
              local dy = r2 < 1 and sqrt(r2) - 1 or 1 - sqrt(2 - r2)
              local d = cx * (((sx + 0.5 + dx) / 2 + x) / w - 0.5)
                      + cy * (((sy + 0.5 + dy) / 2 + y) / h - 0.5)
                      + cam.direction
              local newRay = Ray(cam.origin + d * 140, d:norm())
			        local newRadiance = radiance(scene, newRay, nil, 0, max_depth)
              r = r +  newRadiance * (1/spp)
            end                        
            map[h-y-1][x] = map[h-y-1][x] + (r:clamp() * inv_aa_sq) -- Flips image on Y-axis         
          end
        end
        
			-- Yields current progress
      coroutine.yield(false, (((y * w) + (y + x))*100)/npix)
      end
    end
    
    -- Maps gamma correction and returns output
    coroutine.yield(true, mapfunc(map, mapGamma, gammaFactor, colorRange))
  end


  -- Rendering : default parameters
  local def_param = {
    -- viewport size
    width = 640, height = 480,
     -- depth, anti-aliasing, samples per pixel
    min_depth = 2, min_aa = 2, min_spp = 1,
    -- camera default pos vector and lookAt vector
    eye = Vec3(50,52,295.6), gaze = Vec3(0,-0.062612,-1):norm(), 
    -- field of view (FOV) in radians
    fov = 1.03153
  }

  -- Public API
  local GIRenderer = {}
  GIRenderer.__index = GIRenderer

  -- Inits a new renderer
  function GIRenderer:newRenderer(width, height, aa, spp, maxDepth)
    local renderer = setmetatable({},GIRenderer)
    return renderer:setViewport(width or def_param.width, height or def_param.height)
                   :setAA(aa or def_param.min_aa)
                   :setSPP(spp or def_param.min_spp)
                   :setMaxDepth(maxDepth or def_param.min_depth)
                   :setCam(def_param.eye, def_param.gaze, def_param.fov)
  end

  -- Sets viewport size
  function GIRenderer:setViewport(width, height)
    assertf.isIntHigherThan(width, 0, 'Arg #1 <width>: Positive integer expected')
    assertf.isIntHigherThan(height, 0, 'Arg #2 <height>: Positive integer expected')
    self.width = width
    self.height = height
    return self
  end

  -- Sets antialiasing factor (sub-pixels)
  function GIRenderer:setAA(aa)
    assertf.isIntHigherOrEqTo(aa, 2,
      ('Arg #3 <aa>: Positive integer higher or equal to %d expected')
        :format(def_param.min_aa))
    self.aa = aa
    return self
  end

  -- Set the number of samples per pixels
  -- Higher  values means better rendering but slower processing
  function GIRenderer:setSPP(spp)
    assertf.isIntHigherOrEqTo(spp, 1,
      ('Arg #4 <spp>: Positive integer higher or equal to %d expected')
        :format(def_param.min_spp))
    self.spp = spp
    return self
  end

  -- Max depth for radiance evaluation 
  -- A value of 5 is recommended
  function GIRenderer:setMaxDepth(depth)
    assertf.isIntHigherOrEqTo(depth, 2,
      ('Arg #5 <maxDepth>: Positive integer higher or equal to %d expected')
        :format(def_param.min_depth))
    self.max_depth = depth
    return self
  end

  -- Set camera position, lookAt and field of view
  function GIRenderer:setCam(eye, gaze, fov)
    assertf.isTable(eye,'Arg #1 <eye>: Table expected')
    assertf.isTable(gaze,'Arg #2 <gaze>: Table expected')
    assertf.isNumber(fov,'Arg #3 <fov>: Number expected')
    self.eye, self.gaze, self.fov = eye, gaze, (fov % tau)
    return self
  end

  -- Renders scene
  -- Needs to be continously called until rendering terminates
  function GIRenderer:render(scene)    
    if not self.__renderer then
      self.__renderer = coroutine.create(render)
    end
    local _, status, progress = coroutine.resume(
      self.__renderer,
      scene,
        self.width, self.height,
        self.aa, self.spp, self.max_depth,
        self.eye, self.gaze, self.fov)
    return status, progress
    --[[
    render(scene,self.width, self.height,
        self.aa, self.spp, self.max_depth,
        self.eye, self.gaze, self.fov)
    --]]
  end

  return setmetatable(GIRenderer,
    {__call= function(self,...)
        return GIRenderer:newRenderer(...)
      end
    })

end
