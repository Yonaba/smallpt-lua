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
  local ipairs = ipairs

  -- Shaders
  local _BASE = (...):match('(.*)scene$')
  
  -- Push all existing shaders in each scene
  local SHADERS = {
    ['DIFF'] = require (_BASE .. ('shaders.diffuse')),
    ['REFR'] = require (_BASE .. ('shaders.refractive')),
    ['SPEC'] = require (_BASE .. ('shaders.specular'))
  }

  -- Ray vs Sphere intersection check
  local INF = math.huge -- Maximum distance
  local MINIMAL_HIT = 1e-4 -- Minimal distance
  
  -- Scene API
  local Scene = {}
  Scene.__index = Scene

  -- Inits a new scene
  function Scene:new()
    return setmetatable({
      primitives = {},
      shaders =  SHADERS,
    },Scene)
  end

  -- Adds primitives
  function Scene:addPrimitive(...)
    for _,prim in ipairs{...} do
      self.primitives[#self.primitives+1] = prim
    end
  end

  -- Nearest sphere ?
  function Scene:getNearestHitPrimitive(ray)
    local t = INF
    local hitPrim
    for i = 1,#self.primitives do
      local d = (self.primitives[i]):hit(ray, MINIMAL_HIT)
      if d and (d < t) then t, hitPrim = d, self.primitives[i] end
    end
    return t, hitPrim
  end

  return setmetatable(Scene,
    {__call= function(self,...)
        return Scene:new(...)
      end
    })

end
